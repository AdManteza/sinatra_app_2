class Track < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :song_title, :artist, presence: true

end