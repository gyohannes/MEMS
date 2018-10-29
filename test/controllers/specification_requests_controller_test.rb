require 'test_helper'

class SpecificationRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @specification_request = specification_requests(:one)
  end

  test "should get index" do
    get specification_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_specification_request_url
    assert_response :success
  end

  test "should create specification_request" do
    assert_difference('SpecificationRequest.count') do
      post specification_requests_url, params: { specification_request: { equipment_name_id: @specification_request.equipment_name_id, facility_id: @specification_request.facility_id, organization_structure_id: @specification_request.organization_structure_id, quantity: @specification_request.quantity, requested_by: @specification_request.requested_by, requested_date: @specification_request.requested_date, requested_to: @specification_request.requested_to, requested_to_org_facility: @specification_request.requested_to_org_facility, requested_to_org_institution: @specification_request.requested_to_org_institution, requested_to_org_structure: @specification_request.requested_to_org_structure } }
    end

    assert_redirected_to specification_request_url(SpecificationRequest.last)
  end

  test "should show specification_request" do
    get specification_request_url(@specification_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_specification_request_url(@specification_request)
    assert_response :success
  end

  test "should update specification_request" do
    patch specification_request_url(@specification_request), params: { specification_request: { equipment_name_id: @specification_request.equipment_name_id, facility_id: @specification_request.facility_id, organization_structure_id: @specification_request.organization_structure_id, quantity: @specification_request.quantity, requested_by: @specification_request.requested_by, requested_date: @specification_request.requested_date, requested_to: @specification_request.requested_to, requested_to_org_facility: @specification_request.requested_to_org_facility, requested_to_org_institution: @specification_request.requested_to_org_institution, requested_to_org_structure: @specification_request.requested_to_org_structure } }
    assert_redirected_to specification_request_url(@specification_request)
  end

  test "should destroy specification_request" do
    assert_difference('SpecificationRequest.count', -1) do
      delete specification_request_url(@specification_request)
    end

    assert_redirected_to specification_requests_url
  end
end
