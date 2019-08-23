module V1
  class CompaniesController < ApplicationController
    before_action :set_company, only: [:show, :update, :destroy]
    #before_action :authenticate_user!
  
    # GET v1/companies
    def index
      @companies = Company.all
  
      render json: @companies
    end
  
    # GET v1/companies/1
    def show
      render json: @company
    end
  
    # POST v1/companies
    def create
      @company = Company.new(company_params)
  
      if @company.save
        render json: @company, status: :created, location: @companies
      else
        render json: ErrorSerializer.serialize(@company.errors), status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT v1/companies/1
    def update
      if @company.update(company_params)
        render json: @company
      else
        render json: ErrorSerializer.serialize(@company.errors), status: :unprocessable_entity
      end
    end
  
    # DELETE v1/companies/1
    def destroy
      if @company.tickets.exists? 
        render json: ErrorSerializer.serialize(@company.errors), status: :conflict
      else
        @company.destroy
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_company
        if params[:ticket_id]
          @company = Ticket.find(params[:ticket_id]).company
          return @company
        end
        
        if Company.exists?(params[:id])
          @company = Company.find(params[:id])
        else
          error = {:id=>["Não encontrado Empresa com o id: #{params[:id]}"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end
  
      # Only allow a trusted parameter "white list" through.
      def company_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name])
      end
  end    
end
