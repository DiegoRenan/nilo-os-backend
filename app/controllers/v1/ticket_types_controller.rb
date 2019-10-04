module V1
  class TicketTypesController < ApplicationController
    before_action :set_type, only: [:show, :update, :destroy]
    before_action :authenticate_user!
  
    # GET v1/ticket_types
    def index
      @types = TicketType.all
  
      render json: @types
    end
  
    # GET v1/ticket_types/1
    def show
      render json: @type
    end
  
    # POST v1/ticket_types
    def create
      @type = TicketType.new(type_params)
  
      if @type.save
        render json: @type, status: :created, location: @types
      else
        render json: ErrorSerializer.serialize(@type.errors), status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT v1/ticket_types/1
    def update
      if @type.update(type_params)
        render json: @type
      else
        render json: ErrorSerializer.serialize(@type.errors), status: :unprocessable_entity
      end
    end
  
    # DELETE v1/ticket_types/1
    def destroy
      if @type.tickets.exists?
        @type.errors.add('Type', 'Possuí Tickets vinculados')
        render json: ErrorSerializer.serialize(@type.errors), status: :conflict
      else
        @type.destroy
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_type
        if TicketType.exists?(params[:id])
          @type = TicketType.find(params[:id])
        else
          error = {:id=>["Não encontrado Type com o id: #{params[:id]}"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end
  
      # Only allow a trusted parameter "white list" through.
      def type_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name])
      end
      
  end 
end

