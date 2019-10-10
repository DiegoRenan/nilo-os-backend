module V1
  class DepartmentsController < ApplicationController
    before_action :set_department, only: [:update, :destroy]
    before_action :set_departments, only: [:show]
    before_action :authenticate_user!

    #GET v1/departments
    def index
      @departments = Department.all 
      
      render json: @departments
    end

    #GET v1/departments/:id
    def show
      render json: @departments, include: [:sectors]
    end

    # POST v1/departments
    def create
      @department = Department.new(department_params)

      if @department.save
        render json: @department, status: :created
      else
        render json: ErrorSerializer.serialize(@department.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT v1/departments/1
    def update
      if @department.update(department_params)
        render json: @department
      else
        render json: ErrorSerializer.serialize(@department.errors), status: :unprocessable_entity
      end
    end

    # DELETE v1/departments/1
    def destroy
      if @department.tickets.exists? || @department.employees.exists? || @department.sectors.exists?
        @department.errors.add('Departamento', 'Possuí Tickets, colaboradores e/ou setores vinculados', message: "Delete todos os Tickets da Empresa antes de prosseguir")
        render json: ErrorSerializer.serialize(@department.errors), status: :conflict
      else
        @department.destroy
      end
    end
    
    private
      def department_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :company_id])
      end

      def set_department
        if Department.exists?(params[:id])
          @department = Department.find(params[:id])
        else
          error = {:id=>["Departamento não encontrado"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end

      def set_departments
        if params[:company_id]
          @departments = Company.find(params[:company_id]).departments
          return @departments
        end
        @departments = Department.where(id: params[:id])
      end

  end
end