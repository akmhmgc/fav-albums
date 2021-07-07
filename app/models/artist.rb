class Artist < ApplicationRecord
  ARTISTS_COUNT = 5
  belongs_to :my_list

  validate :artist_count_must_be_five

  private

  def artist_count_must_be_five
    errors.add(:base, "アーティストの数は必ず#{MAX_POSTS_COUNT}組になるようにしてください。") unless my_list.artists.count == ARTISTS_COUNT
  end
end
