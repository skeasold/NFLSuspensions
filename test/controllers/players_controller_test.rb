require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get player" do
    get :player
    assert_response :success
  end

  test "should get chart" do
    get :chart
    assert_response :success
  end

end
