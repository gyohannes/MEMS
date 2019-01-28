require 'test_helper'

class StoreRegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store_registration = store_registrations(:one)
  end

  test "should get index" do
    get store_registrations_url
    assert_response :success
  end

  test "should get new" do
    get new_store_registration_url
    assert_response :success
  end

  test "should create store_registration" do
    assert_difference('StoreRegistration.count') do
      post store_registrations_url, params: { store_registration: { been_number: @store_registration.been_number, equipment_id: @store_registration.equipment_id, store_id: @store_registration.store_id } }
    end

    assert_redirected_to store_registration_url(StoreRegistration.last)
  end

  test "should show store_registration" do
    get store_registration_url(@store_registration)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_registration_url(@store_registration)
    assert_response :success
  end

  test "should update store_registration" do
    patch store_registration_url(@store_registration), params: { store_registration: { been_number: @store_registration.been_number, equipment_id: @store_registration.equipment_id, store_id: @store_registration.store_id } }
    assert_redirected_to store_registration_url(@store_registration)
  end

  test "should destroy store_registration" do
    assert_difference('StoreRegistration.count', -1) do
      delete store_registration_url(@store_registration)
    end

    assert_redirected_to store_registrations_url
  end
end
