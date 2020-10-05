class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes  :email,
              :api_key
                                       
end