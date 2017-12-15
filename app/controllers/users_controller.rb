class UsersController < ApplicationController

    skip_before_action :require_login, only: [:new, :create]

    def new
        return redirect_to show_user_path(session[:user_id]) if session[:user_id]
    end

    def create
        user = User.new(user_params)
        unless user.valid?
            user.errors.each do |tag, error|
                flash[tag.to_sym] ||= []
                flash[tag.to_sym] << error
            end
            return redirect_to sign_in_path
        end
        user.save
        session[:user_id] = user.id
        return redirect_to songs_path
    end

    def show
        @user = User.find_by(id: params[:id])
        return redirect_to cheeky_path if @user == nil
        @songs = Song.joins(:users).where("adds.user_id = #{@user.id}").group("songs.id").order("count(songs.id) DESC")
        @recent = Song.find_by(id: @user.add.last.song_id) if @user.add.last != nil
    end

    private
        def user_params
            params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
        end
end
