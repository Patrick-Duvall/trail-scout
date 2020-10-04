class TrailSearch < ApplicationRecord
  validates_presence_of :city

  scope :quality_searches, -> {
    where(sort: 'quality')
  }

  scope :distance_searches, -> {
    where(sort: 'distance')
  }

  enum sort: {
    quality: 0,
    distance: 1
  }

end