class Api::V1::TrailSerializer < ActiveModel::Serializer
  attributes  :name,
              :summary,
              :location,
              :url,
              :length,
              :distance,
              :stars 
                                       
end
