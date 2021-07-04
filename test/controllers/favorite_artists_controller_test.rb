require 'test_helper'

class FavoriteArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_artists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_artists_destroy_url
    assert_response :success
  end

end
