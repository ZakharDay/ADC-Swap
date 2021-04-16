class Users::SessionsController < Devise::SessionsController
  # prepend_before_action :require_no_authentication, only: [:new, :create]
  # prepend_before_action :allow_params_authentication!, only: :create
  # prepend_before_action :verify_signed_out_user, only: :destroy
  # prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }

  # POST /resource/sign_in
  def create
    puts 'Message from Devise'
    puts params

    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email(email)

    if user
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      guest = Guest.find_by_email(email)

      if guest
        resource = User.create!(email: email, password: password)

        yield resource if block_given?
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message! :notice, :signed_up
            sign_up(resource_name, resource)
            guest.destroy
            respond_with resource, location: after_sign_up_path_for(resource)
          else
            set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
            expire_data_after_sign_in!
            guest.destroy
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          # clean_up_passwords resource
          # set_minimum_password_length
          # respond_with resource
        end
      end
    end
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

end
