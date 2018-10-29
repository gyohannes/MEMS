require 'test_helper'

class BudgetRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget_request = budget_requests(:one)
  end

  test "should get index" do
    get budget_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_budget_request_url
    assert_response :success
  end

  test "should create budget_request" do
    assert_difference('BudgetRequest.count') do
      post budget_requests_url, params: { budget_request: { amount: @budget_request.amount, budget_description: @budget_request.budget_description, budget_name: @budget_request.budget_name, contact_address: @budget_request.contact_address, facility_id: @budget_request.facility_id, organization_structure_id: @budget_request.organization_structure_id, request_date: @budget_request.request_date, request_to_facility: @budget_request.request_to_facility, request_to_org_structure: @budget_request.request_to_org_structure, requested_by: @budget_request.requested_by, requested_to: @budget_request.requested_to } }
    end

    assert_redirected_to budget_request_url(BudgetRequest.last)
  end

  test "should show budget_request" do
    get budget_request_url(@budget_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_budget_request_url(@budget_request)
    assert_response :success
  end

  test "should update budget_request" do
    patch budget_request_url(@budget_request), params: { budget_request: { amount: @budget_request.amount, budget_description: @budget_request.budget_description, budget_name: @budget_request.budget_name, contact_address: @budget_request.contact_address, facility_id: @budget_request.facility_id, organization_structure_id: @budget_request.organization_structure_id, request_date: @budget_request.request_date, request_to_facility: @budget_request.request_to_facility, request_to_org_structure: @budget_request.request_to_org_structure, requested_by: @budget_request.requested_by, requested_to: @budget_request.requested_to } }
    assert_redirected_to budget_request_url(@budget_request)
  end

  test "should destroy budget_request" do
    assert_difference('BudgetRequest.count', -1) do
      delete budget_request_url(@budget_request)
    end

    assert_redirected_to budget_requests_url
  end
end
