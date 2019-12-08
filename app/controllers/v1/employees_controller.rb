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
      begin
        @employee = Employee.new(unserialized_params)
        if @employee.save
          if !params[:password].nil? && !params[:password_confirmation].nil?
            password = params[:password]
            password_confirmation = params[:password_confirmation]
            master = params[:master]
            
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
      rescue Exception => e
        error = {:server => ["Erro 500"]}
        render json: ErrorSerializer.serialize(error), status: :internal_server_error
      end
    end

    # PATCH/PUT v1/companies/1
    def update
      begin
        if @employee.update(unserialized_params)
          render json: @employee
        else
          render json: ErrorSerializer.serialize(@employee.errors), status: :unprocessable_entity
        end
      rescue Exception => e
        error = {:server => ["Erro 500"]}
        render json: ErrorSerializer.serialize(error), status: :internal_server_error
      end
    end

    def destroy
      if @employee.tickets.exists? || @employee.responsibles.exists?
        @employee.errors.add('Colaborador', 'Possuí Tickets vinculados')
        render json: ErrorSerializer.serialize(@employee.errors), status: :conflict
      else
        @employee.destroy
      end
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

      def unserialized_params
        { email: params[:email], 
          name: params[:name], 
          cpf: params[:cpf],
          born: params[:born], 
          company_id: params[:company], 
          department_id: params[:department],
          sector_id: params[:sector],
          cep: params[:cep],
          street: params[:street],
          number: params[:number],
          district: params[:district],
          city: params[:city],
          uf: params[:uf],
          avatar: params[:avatar]}
      end
      # Only allow a trusted parameter "white list" through.
      def employee_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [ 
                                                                              :avatar,
                                                                              :name,
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

