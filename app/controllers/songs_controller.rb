class SongsController < ApplicationController
    def index
        @user = current_user

        @songs = Song.joins("LEFT JOIN adds ON adds.song_id = songs.id").group("songs.id").order("count(adds.song_id) DESC")
    end

    def create
        song = Song.new(song_params)
        unless song.valid?
            song.errors.each do |tag, error|
                flash[tag.to_sym] ||= []
                flash[tag.to_sym] << error
            end
        else
            song.save
        end
        return redirect_to songs_path
    end

    def show
        @song = Song.find_by(id: params[:id])
        return redirect_to cheeky_path if @song == nil
        @users = User.joins(:added_songs).where.not(id: session[:user_id]).where("adds.song_id = #{params[:id]}").group("users.id").order("count(songs.id) DESC")
        @recent = User.find_by(id: @song.add.last.user_id)
    end

    private
        def song_params
            params.require(:song).permit(:title, :artist)
        end
end
