module V1
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:update, :destroy]
    before_action :set_tickets, only: [:show]
    before_action :authenticate_user!
  
    # GET /tickets
    def index
      @tickets = Ticket.all
  
      render json: @tickets
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
  
    # PATCH/PUT /tickets/1
    def update
      if @ticket.update(ticket_params)
        render json: @ticket
      else
        render json: ErrorSerializer.serialize(@company.errors), status: :unprocessable_entity
      end
    end
  
    # DELETE /tickets/1
    def destroy
      @ticket.destroy
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
        @tickets = Ticket.where(id: params[:id])
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
