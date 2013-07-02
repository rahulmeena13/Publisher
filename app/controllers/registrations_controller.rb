  class RegistrationsController < Devise::RegistrationsController
    def create
      if verify_recaptcha
        super
      else
        build_resource
        clean_up_passwords(resource)
        flash.now[:alert] = "Please verify you're human, enter the code correctly."      
        flash.delete :recaptcha_error
        render :new
      end
    end
  end