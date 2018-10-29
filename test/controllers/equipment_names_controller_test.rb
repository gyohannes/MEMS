require 'test_helper'

class EquipmentNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipment_name = equipment_names(:one)
  end

  test "should get index" do
    get equipment_names_url
    assert_response :success
  end

  test "should get new" do
    get new_equipment_name_url
    assert_response :success
  end

  test "should create equipment_name" do
    assert_difference('EquipmentName.count') do
      post equipment_names_url, params: { equipment_name: { equipment_category_id: @equipment_name.equipment_category_id, name: @equipment_name.name } }
    end

    assert_redirected_to equipment_name_url(EquipmentName.last)
  end

  test "should show equipment_name" do
    get equipment_name_url(@equipment_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipment_name_url(@equipment_name)
    assert_response :success
  end

  test "should update equipment_name" do
    patch equipment_name_url(@equipment_name), params: { equipment_name: { equipment_category_id: @equipment_name.equipment_category_id, name: @equipment_name.name } }
    assert_redirected_to equipment_name_url(@equipment_name)
  end

  test "should destroy equipment_name" do
    assert_difference('EquipmentName.count', -1) do
      delete equipment_name_url(@equipment_name)
    end

    assert_redirected_to equipment_names_url
  end
end
