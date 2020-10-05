class Api::V1::TrailSearchSerializer < ActiveModel::Serializer
  include Api::V1::RemoveNullAttributes
  attributes  :city,
              :max_distance,
              :max_results,
              :sort,
              :min_length,
              :min_stars                            
end
