FactoryBot.define do
  factory :my_artist_cookie do
    id { |n| n.to_s }
    name { 'foobar' }
    image_url { 'https://artist.com/artist' }
  end
end
