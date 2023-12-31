class CustomRegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:cast).permit(:email, :password, :password_confirmation, :company_id, :family_name, :first_name, :image)
  end

  def account_update_params
    params.require(:cast).permit(:email, :password, :password_confirmation, :current_password, :image)
  end
end