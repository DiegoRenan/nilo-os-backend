class AvatarController < ApplicationController
  before_action :set_employee
  before_action :authenticate_user!

  def show
    if @employee.avatar.attached?
     render json: url_for(@employee.avatar)
    end
  end

  def create
    @employee.avatar.attach(avatar_params)

    if @employee.avatar.attached?
      render :nothing => true, status: :created
    else
      error = {:image=>["Erro ao cadastrar imagem"]}
      render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
    end

  end

  private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def avatar_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:avatar])
    end

end
