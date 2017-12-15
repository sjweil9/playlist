class SessionsController < ApplicationController

    skip_before_action :require_login, only: [:create]

    def create
        user = User.find_by(email: params[:email])
        unless user
            flash[:log_in_email] = ["Email not found."]
            return redirect_to sign_in_path
        end
        unless user.authenticate(params[:password])
            flash[:log_in_password] = ["Password incorrect."]
            return redirect_to sign_in_path
        end
        session[:user_id] = user.id
        return redirect_to songs_path
    end

    def destroy
        reset_session
        return redirect_to sign_in_path
    end

    def cheeky
        @user = current_user
        session[:cheeky] = true
    end

end
