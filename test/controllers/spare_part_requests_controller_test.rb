require 'test_helper'

class SparePartRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spare_part_request = spare_part_requests(:one)
  end

  test "should get index" do
    get spare_part_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_spare_part_request_url
    assert_response :success
  end

  test "should create spare_part_request" do
    assert_difference('SparePartRequest.count') do
      post spare_part_requests_url, params: { spare_part_request: { facility_id: @spare_part_request.facility_id, model: @spare_part_request.model, organization_structure_id: @spare_part_request.organization_structure_id, power_requirement: @spare_part_request.power_requirement, quantity: @spare_part_request.quantity, request_date: @spare_part_request.request_date, request_to_facility: @spare_part_request.request_to_facility, request_to_institution: @spare_part_request.request_to_institution, request_to_org_structure: @spare_part_request.request_to_org_structure, requested_by: @spare_part_request.requested_by, requested_to: @spare_part_request.requested_to, spare_part_name: @spare_part_request.spare_part_name, volts_ampere: @spare_part_request.volts_ampere } }
    end

    assert_redirected_to spare_part_request_url(SparePartRequest.last)
  end

  test "should show spare_part_request" do
    get spare_part_request_url(@spare_part_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_spare_part_request_url(@spare_part_request)
    assert_response :success
  end

  test "should update spare_part_request" do
    patch spare_part_request_url(@spare_part_request), params: { spare_part_request: { facility_id: @spare_part_request.facility_id, model: @spare_part_request.model, organization_structure_id: @spare_part_request.organization_structure_id, power_requirement: @spare_part_request.power_requirement, quantity: @spare_part_request.quantity, request_date: @spare_part_request.request_date, request_to_facility: @spare_part_request.request_to_facility, request_to_institution: @spare_part_request.request_to_institution, request_to_org_structure: @spare_part_request.request_to_org_structure, requested_by: @spare_part_request.requested_by, requested_to: @spare_part_request.requested_to, spare_part_name: @spare_part_request.spare_part_name, volts_ampere: @spare_part_request.volts_ampere } }
    assert_redirected_to spare_part_request_url(@spare_part_request)
  end

  test "should destroy spare_part_request" do
    assert_difference('SparePartRequest.count', -1) do
      delete spare_part_request_url(@spare_part_request)
    end

    assert_redirected_to spare_part_requests_url
  end
end
