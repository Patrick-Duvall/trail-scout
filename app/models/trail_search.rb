class TrailSearch < ApplicationRecord
  validates_presence_of :city

  enum sort: {
    quality: 0,
    distance: 1
  }

end