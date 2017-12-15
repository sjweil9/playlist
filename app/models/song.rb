class Song < ActiveRecord::Base
    validates :artist, :title, length: { in: 2..45, message: "Song fields must be between 2 and 45 characters." }

    has_many :add
    has_many :users, through: :add, source: :user
end
