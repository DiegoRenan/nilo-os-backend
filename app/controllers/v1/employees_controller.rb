module V1
  class EmployeesController < ApplicationController
    before_action :set_employee, only: [:update, :destroy]
    before_action :set_employees, only: [:show]
    before_action :authenticate_user!
    
    # GET v1/employees
    def index
      @employees = Employee.all 

      render json: @employees
    end

    # GET v1/employee/:id
    def show
      render json: @employees, include: [:company, :department, :sector]
    end

    # POST v1/employees
    def create
      @employee = Employee.new(employee_params)

      if @employee.save
        
        if !params[:data][:attributes][:password].nil? && !params[:data][:attributes][:password_confirmation].nil?
          password = params[:data][:attributes][:password]
          password_confirmation = params[:data][:attributes][:password_confirmation]
          master = params[:data][:attributes][:master]
          
          user = @employee.create_user!(email: @employee.email, password: password, password_confirmation: password_confirmation, master: master)

          if !user.valid?
            @employee.errors.add({:password =>["Não foi possível criar um login. Verifique as informações dadas"]})
          end
        
          render json: @employee, status: :created
        else
          @employee.errors.add('Usuário', 'Criada sem login')
          render json: ErrorSerializer.serialize(@employee.errors), status: :unprocessable_entity
        end

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

      def set_employees
        if params[:company_id]
          @employees = Company.find(params[:company_id]).employees
          return @employees
        end
        @employees = Employee.where(id: params[:id])
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
                                                                              :company_id,
                                                                              :department_id,
                                                                              :sector_id])
      end

  end  
end

