class TrailSearch < ApplicationRecord
  validates_presence_of :city
  belongs_to :user, :class_name => "User" 

  enum sort: {
    quality: 0,
    distance: 1
  }

end