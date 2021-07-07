class MyList < ApplicationRecord
  generate_public_uid
  has_many :artists, dependent: :destroy

  def to_param
    public_uid
  end
end
