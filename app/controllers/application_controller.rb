class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ErrorSerializer
  before_action :ensure_json_request

  # Return only if client accepts Mime Type vnd.api+json results
  def ensure_json_request
    return if request.headers["Accept"] =~ /vnd\.api\+json/
    render :nothing => true, :status => 406
  end

end
