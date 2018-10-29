require 'test_helper'

class DisposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disposal = disposals(:one)
  end

  test "should get index" do
    get disposals_url
    assert_response :success
  end

  test "should get new" do
    get new_disposal_url
    assert_response :success
  end

  test "should create disposal" do
    assert_difference('Disposal.count') do
      post disposals_url, params: { disposal: { action_taken: @disposal.action_taken, contact_address: @disposal.contact_address, disposed_date: @disposal.disposed_date, equipment_id: @disposal.equipment_id, list_of_disposing_commitee: @disposal.list_of_disposing_commitee, problem: @disposal.problem } }
    end

    assert_redirected_to disposal_url(Disposal.last)
  end

  test "should show disposal" do
    get disposal_url(@disposal)
    assert_response :success
  end

  test "should get edit" do
    get edit_disposal_url(@disposal)
    assert_response :success
  end

  test "should update disposal" do
    patch disposal_url(@disposal), params: { disposal: { action_taken: @disposal.action_taken, contact_address: @disposal.contact_address, disposed_date: @disposal.disposed_date, equipment_id: @disposal.equipment_id, list_of_disposing_commitee: @disposal.list_of_disposing_commitee, problem: @disposal.problem } }
    assert_redirected_to disposal_url(@disposal)
  end

  test "should destroy disposal" do
    assert_difference('Disposal.count', -1) do
      delete disposal_url(@disposal)
    end

    assert_redirected_to disposals_url
  end
end
