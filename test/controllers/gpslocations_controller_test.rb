require 'test_helper'

class GpslocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gpslocation = gpslocations(:one)
  end

  test "should get index" do
    get gpslocations_url
    assert_response :success
  end

  test "should get new" do
    get new_gpslocation_url
    assert_response :success
  end

  test "should create gpslocation" do
    assert_difference('Gpslocation.count') do
      post gpslocations_url, params: { gpslocation: { address: @gpslocation.address, latitude: @gpslocation.latitude, longitude: @gpslocation.longitude, name: @gpslocation.name } }
    end

    assert_redirected_to gpslocation_url(Gpslocation.last)
  end

  test "should show gpslocation" do
    get gpslocation_url(@gpslocation)
    assert_response :success
  end

  test "should get edit" do
    get edit_gpslocation_url(@gpslocation)
    assert_response :success
  end

  test "should update gpslocation" do
    patch gpslocation_url(@gpslocation), params: { gpslocation: { address: @gpslocation.address, latitude: @gpslocation.latitude, longitude: @gpslocation.longitude, name: @gpslocation.name } }
    assert_redirected_to gpslocation_url(@gpslocation)
  end

  test "should destroy gpslocation" do
    assert_difference('Gpslocation.count', -1) do
      delete gpslocation_url(@gpslocation)
    end

    assert_redirected_to gpslocations_url
  end
end
