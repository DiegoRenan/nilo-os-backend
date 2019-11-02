module V1
  class TicketStatusesController < ApplicationController
    before_action :set_status, only: [:show, :update, :destroy]
    before_action :authenticate_user!
    before_action :only_admin, except: [:index, :show]
  
    # GET v1/ticket_statuses
    def index
      @statuses = TicketStatus.all
  
      render json: @statuses
    end
  
    # GET v1/ticket_statuses/1
    def show
      render json: @status
    end
  
    # POST v1/ticket_statuses
    def create
      @status = TicketStatus.new(status_params)
  
      if @status.save
        render json: @status, status: :created, location: @statuses
      else
        render json: ErrorSerializer.serialize(@status.errors), status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT v1/ticket_statuses/1
    def update
      if @status.update(status_params)
        render json: @status
      else
        render json: ErrorSerializer.serialize(@status.errors), status: :unprocessable_entity
      end
    end
  
    # DELETE v1/ticket_statuses/1
    def destroy
      if @status.tickets.exists?
        @status.errors.add('Status', 'Possuí Tickets vinculados')
        render json: ErrorSerializer.serialize(@status.errors), status: :conflict
      else
        @status.destroy
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_status
        if TicketStatus.exists?(params[:id])
          @status = TicketStatus.find(params[:id])
        else
          error = {:id=>["Não encontrado Status com o id: #{params[:id]}"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end

      def only_admin
        unless current_user.admin?
          error = {:acesso=>["Acesso não autorizado"]}
          render json: ErrorSerializer.serialize(error), status: :unauthorized
        end
      end
  
      # Only allow a trusted parameter "white list" through.
      def status_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:status])
      end
  end
end

