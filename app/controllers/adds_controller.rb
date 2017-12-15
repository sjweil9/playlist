class AddsController < ApplicationController
    def create
        song = Song.find_by(id: params[:id])
        if song != nil
            Add.create(user_id: session[:user_id], song_id: song.id) if song != nil
        else
            return redirect_to cheeky_path
        end
        return redirect_to songs_path
    end
end
