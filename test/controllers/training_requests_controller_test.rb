require 'test_helper'

class TrainingRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_request = training_requests(:one)
  end

  test "should get index" do
    get training_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_training_request_url
    assert_response :success
  end

  test "should create training_request" do
    assert_difference('TrainingRequest.count') do
      post training_requests_url, params: { training_request: { facility_id: @training_request.facility_id, organization_structure_id: @training_request.organization_structure_id, request_date: @training_request.request_date, request_to_facility: @training_request.request_to_facility, request_to_institution: @training_request.request_to_institution, request_to_org_structure: @training_request.request_to_org_structure, requested_by: @training_request.requested_by, requested_to: @training_request.requested_to, trainee_type: @training_request.trainee_type, training_description: @training_request.training_description } }
    end

    assert_redirected_to training_request_url(TrainingRequest.last)
  end

  test "should show training_request" do
    get training_request_url(@training_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_request_url(@training_request)
    assert_response :success
  end

  test "should update training_request" do
    patch training_request_url(@training_request), params: { training_request: { facility_id: @training_request.facility_id, organization_structure_id: @training_request.organization_structure_id, request_date: @training_request.request_date, request_to_facility: @training_request.request_to_facility, request_to_institution: @training_request.request_to_institution, request_to_org_structure: @training_request.request_to_org_structure, requested_by: @training_request.requested_by, requested_to: @training_request.requested_to, trainee_type: @training_request.trainee_type, training_description: @training_request.training_description } }
    assert_redirected_to training_request_url(@training_request)
  end

  test "should destroy training_request" do
    assert_difference('TrainingRequest.count', -1) do
      delete training_request_url(@training_request)
    end

    assert_redirected_to training_requests_url
  end
end
