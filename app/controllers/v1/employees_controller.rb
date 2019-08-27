module V1
  class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :update, :destroy]

    # GET v1/employees
    def index
      @employees = Employee.all 

      render json: @employees
    end

    # GET v1/employee/:id
    def show
      render json: @employee
    end

    # POST v1/employees
    def create
      @employee = Employee.new(employee_params)

      if @employee.save
        render json: @employee, status: :created
      else
        render json: ErrorSerializer.serialize(@employee.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT v1/companies/1
    def update
      if @employee.update(employee_params)
        render json: @employee
      else
        render json: ErrorSerializer.serialize(@employee.errors), status: :unprocessable_entity
      end
    end

    def destroy
      @employee.destroy
    end

    private
      def set_employee
        if Employee.exists?(params[:id])
          @employee = Employee.find(params[:id])
        else
          error = {:id=>["Não encontrado Funcionário com o id: #{params[:id]}"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end

      # Only allow a trusted parameter "white list" through.
      def employee_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name,
                                                                              :cpf,
                                                                              :born,
                                                                              :email,
                                                                              :street,
                                                                              :number,
                                                                              :district,
                                                                              :city,
                                                                              :uf,
                                                                              :cep,
                                                                              :company_id])
      end

  end  
end

