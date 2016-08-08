class Track < ActiveRecord::Base

  validates :song_title, :artist, presence: true

end