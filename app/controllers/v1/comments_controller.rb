module V1
  class CommentsController < ApplicationController
    before_action :set_comments, only: [:show]
    before_action :set_comment, only: [:update, :destroy]
    before_action :authenticate_user!
  
    # GET v1/comments
    def index
      @comments = Comment.all
  
      render json: @comments
    end
  
    # GET v1/comments/1
    def show
      render json: @comments
    end
  
    # POST v1/comments
    def create
      @comment = Comment.new(comment_params)
  
      if @comment.save
        render json: @comment, status: :created, location: @comments
      else
        render json: ErrorSerializer.serialize(@comment.errors), status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT v1/comments/1
    def update
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: ErrorSerializer.serialize(@comment.errors), status: :unprocessable_entity
      end
    end
  
    # DELETE v1/comments/1
    def destroy
      @comment.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comments
        
        if params[:ticket_id]
          @comments = Ticket.find(params[:ticket_id]).comments
          return @comments
        end

        if params[:employee_id]
          @comments = Employee.find(params[:employee_id]).comments
          return @comments
        end
        
        if Comment.exists?(params[:id])
          @comments = Comment.where(id: params[:id])
        else
          error = {:id=>["Comentario não encontrado"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end

      end

      def set_comment
        if Comment.exists?(params[:id])
          @comment = Comment.find(params[:id])
        else
          error = {:id=>["Comentario não encontrado"]}
          render json: ErrorSerializer.serialize(error), status: :unprocessable_entity
        end
      end
  
      # Only allow a trusted parameter "white list" through.
      def comment_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:body, :employee_id, :ticket_id])
      end

  end  
end

