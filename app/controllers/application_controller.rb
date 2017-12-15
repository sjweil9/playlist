class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    before_action :require_login

    def current_user
        if session[:user_id]
            columns = User.attribute_names - ['password_digest']
            User.select(columns).find_by(id: session[:user_id])
        end
    end

    helper_method :current_user

    private
        def require_login
            return redirect_to sign_in_path unless session.has_key?("user_id")
        end
end
