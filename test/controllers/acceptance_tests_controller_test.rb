require 'test_helper'

class AcceptanceTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acceptance_test = acceptance_tests(:one)
  end

  test "should get index" do
    get acceptance_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_acceptance_test_url
    assert_response :success
  end

  test "should create acceptance_test" do
    assert_difference('AcceptanceTest.count') do
      post acceptance_tests_url, params: { acceptance_test: { acceptance_testing_date: @acceptance_test.acceptance_testing_date, accepted: @acceptance_test.accepted, approved_by: @acceptance_test.approved_by, contact_address: @acceptance_test.contact_address, end_users_trained: @acceptance_test.end_users_trained, equipment_id: @acceptance_test.equipment_id, installation_done: @acceptance_test.installation_done, maintenance_personnel_trained: @acceptance_test.maintenance_personnel_trained, meet_standard: @acceptance_test.meet_standard, note: @acceptance_test.note, status: @acceptance_test.status, test_run: @acceptance_test.test_run, with_full_accessery: @acceptance_test.with_full_accessery, with_manual: @acceptance_test.with_manual, with_order_specification: @acceptance_test.with_order_specification } }
    end

    assert_redirected_to acceptance_test_url(AcceptanceTest.last)
  end

  test "should show acceptance_test" do
    get acceptance_test_url(@acceptance_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_acceptance_test_url(@acceptance_test)
    assert_response :success
  end

  test "should update acceptance_test" do
    patch acceptance_test_url(@acceptance_test), params: { acceptance_test: { acceptance_testing_date: @acceptance_test.acceptance_testing_date, accepted: @acceptance_test.accepted, approved_by: @acceptance_test.approved_by, contact_address: @acceptance_test.contact_address, end_users_trained: @acceptance_test.end_users_trained, equipment_id: @acceptance_test.equipment_id, installation_done: @acceptance_test.installation_done, maintenance_personnel_trained: @acceptance_test.maintenance_personnel_trained, meet_standard: @acceptance_test.meet_standard, note: @acceptance_test.note, status: @acceptance_test.status, test_run: @acceptance_test.test_run, with_full_accessery: @acceptance_test.with_full_accessery, with_manual: @acceptance_test.with_manual, with_order_specification: @acceptance_test.with_order_specification } }
    assert_redirected_to acceptance_test_url(@acceptance_test)
  end

  test "should destroy acceptance_test" do
    assert_difference('AcceptanceTest.count', -1) do
      delete acceptance_test_url(@acceptance_test)
    end

    assert_redirected_to acceptance_tests_url
  end
end
