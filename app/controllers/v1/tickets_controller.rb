module V1
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:update, :destroy, :close, :aprove]
    before_action :set_tickets, only: [:show]
    before_action :authenticate_user!
  
    # GET /tickets
    def index
      if current_user.admin? || current_user.master?
        @tickets = Ticket.all 
        render json: @tickets
      else
        user_tickets
        render json: @tickets
      end
    end
  
    # GET /tickets/1
    def show
      if current_user.admin? || current_user.master?
        render json: @tickets, include: [:company, 
                                        :department,
                                        :sector,
                                        :ticket_status,
                                        :ticket_type,
                                        :employee
                                        ]
      else
        user_ticket_show
        render json: @tickets, include: [:company, 
                                        :department,
                                        :sector,
                                        :ticket_status,
                                        :ticket_type,
                                        :employee
                                        ]
      end

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
      if current_user.admin? || current_user.master? || current_user.employee.eql?(@ticket.employee)
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
          return @tickets
        end
        if params[:employee_id]
          @tickets = Employee.find(params[:employee_id]).tickets
          return @tickets
        end
        @tickets = Ticket.where(id: params[:id])
      end
      
      def user_tickets
        @t_resp = Ticket.where_responsible(current_user.employee)
        @t_aut = Ticket.user_tickets(current_user)
        @t_departments = Ticket.employee_department_tickets(current_user.employee)
        @tickets = @t_resp.concat(@t_aut).concat(@t_departments)
      end

      def user_ticket_show
        ticket_show = []
        @tickets.each do |ticket|
          if ticket.employees.include?(current_user.employee)
            ticket_show.push(ticket)
          elsif ticket.employee.eql?(current_user.employee)
            ticket_show.push(ticket)
          elsif ticket.department.present? && current_user.employee.department.present?
            if ticket.department.eql?(current_user.employee.department)
              ticket_show.push(ticket)
            end
          end 
        end
        @tickets = ticket_show
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
