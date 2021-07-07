class MyList < ApplicationRecord
  has_many :artists, dependent: :destroy
end
