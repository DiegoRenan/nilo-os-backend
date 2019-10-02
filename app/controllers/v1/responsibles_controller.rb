module V1
  class ResponsiblesController < ApplicationController
    before_action :set_responsible, only: [:destroy]
    before_action :set_responsibles, only: [:show]

    def create
      @responsible = Responsible.new(responsible_params)

      if @responsible.save
        render json: @responsible, status: :created
      else
        render json: ErrorSerializer.serialize(@responsible.errors), status: :unprocessable_entity
      end
    end

    def show
      render json: @responsibles
    end

    # DELETE v1/responsibles/1
    def destroy
      @responsible.destroy
    end

    private
      def responsible_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:ticket_id, :employee_id])
      end

      def set_responsible
        @responsible = Responsible.find(params[:id])
      end

      def set_responsibles
        if params[:ticket_id]
          @responsibles = Ticket.find(params[:ticket_id]).responsibles
          return @responsibles
        end
        @responsibles = Responsibles.where(id: params[:id])
      end

  end    
end
