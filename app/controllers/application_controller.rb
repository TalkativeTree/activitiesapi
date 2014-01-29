class ApplicationController < ActionController::API
  helper_method :restrict_access, :client_error

  def restrict_access
    unless params[:token].present? && params[:token] == "12345"
      render status: 401
    end
  end

  def client_error
    render status: 400 
  end
end
