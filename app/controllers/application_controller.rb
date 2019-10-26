class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, except: [:index, :chart], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  after_action :verify_authorized, if: :messages_index?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  # Override Rails.application.default_url_options[:host]
  # Allows image helpers to be fed required absolute URLs
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def messages_index?
    params[:controller] == 'messages' && params[:action] == 'index'
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo, :photo_cache, :remove_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :photo_cache, :remove_photo])
  end
end
