require 'test_helper'

class OrganizationStructureTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_structure_type = organization_structure_types(:one)
  end

  test "should get index" do
    get organization_structure_types_url
    assert_response :success
  end

  test "should get new" do
    get new_organization_structure_type_url
    assert_response :success
  end

  test "should create organization_structure_type" do
    assert_difference('OrganizationStructureType.count') do
      post organization_structure_types_url, params: { organization_structure_type: { description: @organization_structure_type.description, name: @organization_structure_type.name } }
    end

    assert_redirected_to organization_structure_type_url(OrganizationStructureType.last)
  end

  test "should show organization_structure_type" do
    get organization_structure_type_url(@organization_structure_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_structure_type_url(@organization_structure_type)
    assert_response :success
  end

  test "should update organization_structure_type" do
    patch organization_structure_type_url(@organization_structure_type), params: { organization_structure_type: { description: @organization_structure_type.description, name: @organization_structure_type.name } }
    assert_redirected_to organization_structure_type_url(@organization_structure_type)
  end

  test "should destroy organization_structure_type" do
    assert_difference('OrganizationStructureType.count', -1) do
      delete organization_structure_type_url(@organization_structure_type)
    end

    assert_redirected_to organization_structure_types_url
  end
end
