require 'test_helper'

class InstallationRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @installation_request = installation_requests(:one)
  end

  test "should get index" do
    get installation_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_installation_request_url
    assert_response :success
  end

  test "should create installation_request" do
    assert_difference('InstallationRequest.count') do
      post installation_requests_url, params: { installation_request: { equipment_name_id: @installation_request.equipment_name_id, facility_id: @installation_request.facility_id, installation_description: @installation_request.installation_description, model: @installation_request.model, organization_structure_id: @installation_request.organization_structure_id, request_date: @installation_request.request_date, request_to_facility: @installation_request.request_to_facility, request_to_institution: @installation_request.request_to_institution, request_to_org_structure: @installation_request.request_to_org_structure, requested_by: @installation_request.requested_by, requested_to: @installation_request.requested_to } }
    end

    assert_redirected_to installation_request_url(InstallationRequest.last)
  end

  test "should show installation_request" do
    get installation_request_url(@installation_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_installation_request_url(@installation_request)
    assert_response :success
  end

  test "should update installation_request" do
    patch installation_request_url(@installation_request), params: { installation_request: { equipment_name_id: @installation_request.equipment_name_id, facility_id: @installation_request.facility_id, installation_description: @installation_request.installation_description, model: @installation_request.model, organization_structure_id: @installation_request.organization_structure_id, request_date: @installation_request.request_date, request_to_facility: @installation_request.request_to_facility, request_to_institution: @installation_request.request_to_institution, request_to_org_structure: @installation_request.request_to_org_structure, requested_by: @installation_request.requested_by, requested_to: @installation_request.requested_to } }
    assert_redirected_to installation_request_url(@installation_request)
  end

  test "should destroy installation_request" do
    assert_difference('InstallationRequest.count', -1) do
      delete installation_request_url(@installation_request)
    end

    assert_redirected_to installation_requests_url
  end
end
