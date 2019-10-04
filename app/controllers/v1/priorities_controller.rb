module V1
  class PrioritiesController < ApplicationController
    before_action :authenticate_user!

    def index
      @priorities = Priority.all 

      render json: @priorities
    end
    
  end
end

