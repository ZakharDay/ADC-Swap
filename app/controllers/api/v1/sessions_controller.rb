class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:new, :create]

  def create
    puts 'Message from Devise'
    user = User.find_by_email(params[:user][:email])

    if user
      self.resource = warden.authenticate!({:scope=>:user, :recall=>"users/sessions#new"})
      sign_in(resource_name, resource)
      render json: resource
    else
      render json: {error: 'User not found'}
    end
  end

  protected

  # def auth_options
  #   puts '------------------------> auth_options'
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end
  #
  # # Signs in a user on sign up. You can overwrite this method in your own
  # # RegistrationsController.
  # def sign_up(resource_name, resource)
  #   puts '------------------------'
  #   sign_in(resource_name, resource)
  # end
  #
  # # The path used after sign up. You need to overwrite this method
  # # in your own RegistrationsController.
  # def after_sign_up_path_for(resource)
  #   puts '------------------------'
  #   after_sign_in_path_for(resource) if is_navigational_format?
  # end
  #
  # # The path used after sign up for inactive accounts. You need to overwrite
  # # this method in your own RegistrationsController.
  # def after_inactive_sign_up_path_for(resource)
  #   puts '------------------------'
  #   scope = Devise::Mapping.find_scope!(resource)
  #   router_name = Devise.mappings[scope].router_name
  #   context = router_name ? send(router_name) : self
  #   context.respond_to?(:root_path) ? context.root_path : "/"
  # end
end
