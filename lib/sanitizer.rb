class User::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:username, :email, :password, :password_confirmation)
  end
end