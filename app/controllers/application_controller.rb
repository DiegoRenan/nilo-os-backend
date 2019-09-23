class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ErrorSerializer
  before_action :ensure_json_request
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_id, :master, :tec])
    end

    # Return only if client accepts Mime Type vnd.api+json results
    def ensure_json_request
      return if request.headers["Accept"] =~ /json/
      render :nothing => true, :status => 406
    end

end
