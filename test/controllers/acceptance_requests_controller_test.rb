require 'test_helper'

class AcceptanceRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acceptance_request = acceptance_requests(:one)
  end

  test "should get index" do
    get acceptance_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_acceptance_request_url
    assert_response :success
  end

  test "should create acceptance_request" do
    assert_difference('AcceptanceRequest.count') do
      post acceptance_requests_url, params: { acceptance_request: { description: @acceptance_request.description, equipment_name_id: @acceptance_request.equipment_name_id, facility_id: @acceptance_request.facility_id, model: @acceptance_request.model, organization_structure_id: @acceptance_request.organization_structure_id, power_requirement: @acceptance_request.power_requirement, request_date: @acceptance_request.request_date, request_to_facility: @acceptance_request.request_to_facility, request_to_institution: @acceptance_request.request_to_institution, request_to_org_structure: @acceptance_request.request_to_org_structure, requested_by: @acceptance_request.requested_by, requested_to: @acceptance_request.requested_to, volts_ampere: @acceptance_request.volts_ampere } }
    end

    assert_redirected_to acceptance_request_url(AcceptanceRequest.last)
  end

  test "should show acceptance_request" do
    get acceptance_request_url(@acceptance_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_acceptance_request_url(@acceptance_request)
    assert_response :success
  end

  test "should update acceptance_request" do
    patch acceptance_request_url(@acceptance_request), params: { acceptance_request: { description: @acceptance_request.description, equipment_name_id: @acceptance_request.equipment_name_id, facility_id: @acceptance_request.facility_id, model: @acceptance_request.model, organization_structure_id: @acceptance_request.organization_structure_id, power_requirement: @acceptance_request.power_requirement, request_date: @acceptance_request.request_date, request_to_facility: @acceptance_request.request_to_facility, request_to_institution: @acceptance_request.request_to_institution, request_to_org_structure: @acceptance_request.request_to_org_structure, requested_by: @acceptance_request.requested_by, requested_to: @acceptance_request.requested_to, volts_ampere: @acceptance_request.volts_ampere } }
    assert_redirected_to acceptance_request_url(@acceptance_request)
  end

  test "should destroy acceptance_request" do
    assert_difference('AcceptanceRequest.count', -1) do
      delete acceptance_request_url(@acceptance_request)
    end

    assert_redirected_to acceptance_requests_url
  end
end
