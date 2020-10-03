class TrailSearch < ApplicationRecord

    enum :sort, {quality: 0, distance: 1}

end