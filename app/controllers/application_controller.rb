class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :family_name, :company_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:company_id])
    devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :family_name, :company_id, :health,:sara_shiwake_skill,:sara_arai_skill,:sara_nagashi_skill,:sara_huki_skill,:kigu_arai_skill,:kigu_nagashi_skill,:kigu_huki_skill,:kigu_migaki_skill])
  end
end
