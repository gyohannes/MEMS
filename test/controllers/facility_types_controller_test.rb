require 'test_helper'

class FacilityTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facility_type = facility_types(:one)
  end

  test "should get index" do
    get facility_types_url
    assert_response :success
  end

  test "should get new" do
    get new_facility_type_url
    assert_response :success
  end

  test "should create facility_type" do
    assert_difference('FacilityType.count') do
      post facility_types_url, params: { facility_type: { description: @facility_type.description, name: @facility_type.name } }
    end

    assert_redirected_to facility_type_url(FacilityType.last)
  end

  test "should show facility_type" do
    get facility_type_url(@facility_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_facility_type_url(@facility_type)
    assert_response :success
  end

  test "should update facility_type" do
    patch facility_type_url(@facility_type), params: { facility_type: { description: @facility_type.description, name: @facility_type.name } }
    assert_redirected_to facility_type_url(@facility_type)
  end

  test "should destroy facility_type" do
    assert_difference('FacilityType.count', -1) do
      delete facility_type_url(@facility_type)
    end

    assert_redirected_to facility_types_url
  end
end
