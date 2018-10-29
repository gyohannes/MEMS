require 'test_helper'

class EquipmentCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipment_category = equipment_categories(:one)
  end

  test "should get index" do
    get equipment_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_equipment_category_url
    assert_response :success
  end

  test "should create equipment_category" do
    assert_difference('EquipmentCategory.count') do
      post equipment_categories_url, params: { equipment_category: { name: @equipment_category.name } }
    end

    assert_redirected_to equipment_category_url(EquipmentCategory.last)
  end

  test "should show equipment_category" do
    get equipment_category_url(@equipment_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipment_category_url(@equipment_category)
    assert_response :success
  end

  test "should update equipment_category" do
    patch equipment_category_url(@equipment_category), params: { equipment_category: { name: @equipment_category.name } }
    assert_redirected_to equipment_category_url(@equipment_category)
  end

  test "should destroy equipment_category" do
    assert_difference('EquipmentCategory.count', -1) do
      delete equipment_category_url(@equipment_category)
    end

    assert_redirected_to equipment_categories_url
  end
end
