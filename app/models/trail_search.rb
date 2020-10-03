class TrailSearch < ApplicationRecord
  validates_presence_of :city

  enum sort: {
    dollars: 0,
    percentage: 1
  }

end