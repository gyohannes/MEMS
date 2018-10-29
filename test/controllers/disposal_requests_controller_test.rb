require 'test_helper'

class DisposalRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disposal_request = disposal_requests(:one)
  end

  test "should get index" do
    get disposal_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_disposal_request_url
    assert_response :success
  end

  test "should create disposal_request" do
    assert_difference('DisposalRequest.count') do
      post disposal_requests_url, params: { disposal_request: { contact_address: @disposal_request.contact_address, disposal_description: @disposal_request.disposal_description, equipment_id: @disposal_request.equipment_id, facility_id: @disposal_request.facility_id, organization_structure_id: @disposal_request.organization_structure_id, request_date: @disposal_request.request_date, request_to_facility: @disposal_request.request_to_facility, request_to_org_structure: @disposal_request.request_to_org_structure, requested_by: @disposal_request.requested_by, requested_to: @disposal_request.requested_to } }
    end

    assert_redirected_to disposal_request_url(DisposalRequest.last)
  end

  test "should show disposal_request" do
    get disposal_request_url(@disposal_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_disposal_request_url(@disposal_request)
    assert_response :success
  end

  test "should update disposal_request" do
    patch disposal_request_url(@disposal_request), params: { disposal_request: { contact_address: @disposal_request.contact_address, disposal_description: @disposal_request.disposal_description, equipment_id: @disposal_request.equipment_id, facility_id: @disposal_request.facility_id, organization_structure_id: @disposal_request.organization_structure_id, request_date: @disposal_request.request_date, request_to_facility: @disposal_request.request_to_facility, request_to_org_structure: @disposal_request.request_to_org_structure, requested_by: @disposal_request.requested_by, requested_to: @disposal_request.requested_to } }
    assert_redirected_to disposal_request_url(@disposal_request)
  end

  test "should destroy disposal_request" do
    assert_difference('DisposalRequest.count', -1) do
      delete disposal_request_url(@disposal_request)
    end

    assert_redirected_to disposal_requests_url
  end
end
