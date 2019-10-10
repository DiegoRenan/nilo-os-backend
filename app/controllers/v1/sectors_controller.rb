module V1
  class SectorsController < ApplicationController
    before_action :set_sector, only: [:update, :destroy]
    before_action :set_sectors, only: [:show]
    before_action :authenticate_user!

    #GET v1/sectors
    def index
      @sectors = Sector.all 
      
      render json: @sectors
    end

    #GET v1/sectors/:id
    def show
      render json: @sectors, include: [:department]
    end

    # POST v1/sectors
    def create
      @sector = Sector.new(sector_params)

      if @sector.save
        render json: @sector, status: :created
      else
        render json: ErrorSerializer.serialize(@sector.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT v1/sectors/1
    def update
      if @sector.update(sector_params)
        render json: @sector
      else
        render json: ErrorSerializer.serialize(@sector.errors), status: :unprocessable_entity
      end
    end

    # DELETE v1/sectors/1
    def destroy
      if @sector.tickets.exists? || @sector.employees.exists? 
        @sector.errors.add('Setor', 'Possuí Tickets, departamentos e/ou colaboradores vinculados')
        render json: ErrorSerializer.serialize(@sector.errors), status: :conflict
      else
        @sector.destroy
      end
    end

    private
      def sector_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :department_id])
      end

      def set_sector
        if Sector.exists?(params[:id])
          @sector = Sector.find(params[:id])
        else
          error = {:id=>["Setor não encontrado"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end

      def set_sectors
        if params[:department_id]
          @sectors = Department.find(params[:department_id]).sectors
          return @sectors
        end
        @sectors = Sector.where(id: params[:id])
      end
  end
end
