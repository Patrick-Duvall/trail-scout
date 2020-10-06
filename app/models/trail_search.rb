class TrailSearch < ApplicationRecord
  validates_presence_of :city
  belongs_to :user, :class_name => "User", foreign_key: :api_key, primary_key: :api_key

  enum sort: {
    quality: 0,
    distance: 1
  }

end