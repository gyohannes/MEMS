require 'test_helper'

class ProcurementRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @procurement_request = procurement_requests(:one)
  end

  test "should get index" do
    get procurement_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_procurement_request_url
    assert_response :success
  end

  test "should create procurement_request" do
    assert_difference('ProcurementRequest.count') do
      post procurement_requests_url, params: { procurement_request: { contact_email: @procurement_request.contact_email, contact_phone: @procurement_request.contact_phone, facility_id: @procurement_request.facility_id, organization_structure_id: @procurement_request.organization_structure_id, request_to: @procurement_request.request_to, requested_by: @procurement_request.requested_by } }
    end

    assert_redirected_to procurement_request_url(ProcurementRequest.last)
  end

  test "should show procurement_request" do
    get procurement_request_url(@procurement_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_procurement_request_url(@procurement_request)
    assert_response :success
  end

  test "should update procurement_request" do
    patch procurement_request_url(@procurement_request), params: { procurement_request: { contact_email: @procurement_request.contact_email, contact_phone: @procurement_request.contact_phone, facility_id: @procurement_request.facility_id, organization_structure_id: @procurement_request.organization_structure_id, request_to: @procurement_request.request_to, requested_by: @procurement_request.requested_by } }
    assert_redirected_to procurement_request_url(@procurement_request)
  end

  test "should destroy procurement_request" do
    assert_difference('ProcurementRequest.count', -1) do
      delete procurement_request_url(@procurement_request)
    end

    assert_redirected_to procurement_requests_url
  end
end
