require 'test_helper'

class CalibrationRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calibration_request = calibration_requests(:one)
  end

  test "should get index" do
    get calibration_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_calibration_request_url
    assert_response :success
  end

  test "should create calibration_request" do
    assert_difference('CalibrationRequest.count') do
      post calibration_requests_url, params: { calibration_request: { calibration_description: @calibration_request.calibration_description, equipment_id: @calibration_request.equipment_id, facility_id: @calibration_request.facility_id, organization_structure_id: @calibration_request.organization_structure_id, request_date: @calibration_request.request_date, request_to_facility: @calibration_request.request_to_facility, request_to_institution: @calibration_request.request_to_institution, request_to_org_structure: @calibration_request.request_to_org_structure, requested_by: @calibration_request.requested_by, requested_to: @calibration_request.requested_to } }
    end

    assert_redirected_to calibration_request_url(CalibrationRequest.last)
  end

  test "should show calibration_request" do
    get calibration_request_url(@calibration_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_calibration_request_url(@calibration_request)
    assert_response :success
  end

  test "should update calibration_request" do
    patch calibration_request_url(@calibration_request), params: { calibration_request: { calibration_description: @calibration_request.calibration_description, equipment_id: @calibration_request.equipment_id, facility_id: @calibration_request.facility_id, organization_structure_id: @calibration_request.organization_structure_id, request_date: @calibration_request.request_date, request_to_facility: @calibration_request.request_to_facility, request_to_institution: @calibration_request.request_to_institution, request_to_org_structure: @calibration_request.request_to_org_structure, requested_by: @calibration_request.requested_by, requested_to: @calibration_request.requested_to } }
    assert_redirected_to calibration_request_url(@calibration_request)
  end

  test "should destroy calibration_request" do
    assert_difference('CalibrationRequest.count', -1) do
      delete calibration_request_url(@calibration_request)
    end

    assert_redirected_to calibration_requests_url
  end
end
