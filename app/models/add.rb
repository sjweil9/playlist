class Add < ActiveRecord::Base
    belongs_to :user, required: true
    belongs_to :song, required: true
end
