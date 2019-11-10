module V1
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:update, :destroy, :close, :aprove]
    before_action :set_tickets, only: [:show]
    before_action :authenticate_user!
  
    # GET /tickets
    def index
      if current_user.admin? || current_user.master?
        @tickets = Ticket.all

        filter_by_priority if params[:priority]
        render json: @tickets
      else
        @tickets = set_employee_tickets

        filter_by_priority if params[:priority]
        render json: @tickets
      end
    end
  
    # GET /tickets/1
    def show      
      render json: @tickets, include: [:company, 
                                        :department,
                                        :sector,
                                        :ticket_status,
                                        :ticket_type,
                                        :employee
                                        ]
    end
  
    # POST /tickets
    def create
      @ticket = Ticket.new(ticket_params)
  
      if @ticket.save
        render json: @ticket, status: :created, location: @tickets
      else
        render json: ErrorSerializer.serialize(@ticket.errors), status: :unprocessable_entity
      end
    end

    def close
      if current_user.admin? || current_user.master? || current_user.employee.id == current_user.employee.id
        ActiveRecord::Base.transaction do 
          @ticket.close
        end
      end
    end

    def aprove
      if current_user.admin?
        ActiveRecord::Base.transaction do
          @ticket.aprove
          @ticket.set_plan 
        end
      end
    end
  
    # PATCH/PUT /tickets/1
    def update
      if current_user.admin? || current_user.master?
        if @ticket.update(ticket_params)
          render json: @ticket
        else
          render json: ErrorSerializer.serialize(@company.errors), status: :unprocessable_entity
        end
      end
    end
  
    # DELETE /tickets/1
    def destroy
      if current_user.admin?
        @ticket.destroy
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_ticket
        @ticket = Ticket.find(params[:id])
      end
      
      def set_tickets
        if params[:company_id]
          @tickets = Company.find(params[:company_id]).tickets
        end
        
        if params[:employee_id]
          @tickets = Employee.find(params[:employee_id]).tickets
        end

        if params[:id]
          @tickets = Ticket.where(id: params[:id])
        end
        
        unless current_user.admin? || current_user.master?
          ticket_for_user = []
          @tickets.each do |ticket|
           ticket_for_user.push(ticket) if set_employee_tickets.include?(ticket)
          end
          @tickets = ticket_for_user  
        end

      end

      def set_employee_tickets
        Ticket.joins(:responsibles)
              .where("responsibles.employee_id = ? OR tickets.employee_id = ? OR tickets.department_id = ?", 
                      current_user.employee.id, current_user.employee.id, current_user.employee.department.id)
              .distinct
      end

      def filter_by_priority
        @tickets = @tickets.select do |t|
          t.priority.nivel == params[:priority]
        end
      end
      

      # Only allow a trusted parameter "white list" through.
      def ticket_params
        ActiveModelSerializers::Deserialization
          .jsonapi_parse(params, only: [:title, 
                                        :body, 
                                        :conclude_at, 
                                        :company_id, 
                                        :department_id,
                                        :sector_id,
                                        :ticket_status_id,
                                        :ticket_type_id,
                                        :employee_id,
                                        :priority_id])
      end
  end    
end
