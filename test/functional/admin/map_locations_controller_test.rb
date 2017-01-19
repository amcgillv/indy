require 'test_helper'

class Admin::MapLocationsControllerTest < ActionController::TestCase
  setup do
    @admin_map_location = admin_map_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_map_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_map_location" do
    assert_difference('Admin::MapLocation.count') do
      post :create, admin_map_location: { content: @admin_map_location.content, lat: @admin_map_location.lat, lng: @admin_map_location.lng }
    end

    assert_redirected_to admin_map_location_path(assigns(:admin_map_location))
  end

  test "should show admin_map_location" do
    get :show, id: @admin_map_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_map_location
    assert_response :success
  end

  test "should update admin_map_location" do
    put :update, id: @admin_map_location, admin_map_location: { content: @admin_map_location.content, lat: @admin_map_location.lat, lng: @admin_map_location.lng }
    assert_redirected_to admin_map_location_path(assigns(:admin_map_location))
  end

  test "should destroy admin_map_location" do
    assert_difference('Admin::MapLocation.count', -1) do
      delete :destroy, id: @admin_map_location
    end

    assert_redirected_to admin_map_locations_path
  end
end
