require 'test_helper'

class OrganizationStructuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_structure = organization_structures(:one)
  end

  test "should get index" do
    get organization_structures_url
    assert_response :success
  end

  test "should get new" do
    get new_organization_structure_url
    assert_response :success
  end

  test "should create organization_structure" do
    assert_difference('OrganizationStructure.count') do
      post organization_structures_url, params: { organization_structure: { code: @organization_structure.code, name: @organization_structure.name, organization_structure_type_id: @organization_structure.organization_structure_type_id, parent_organization_structure_id: @organization_structure.parent_organization_structure_id } }
    end

    assert_redirected_to organization_structure_url(OrganizationStructure.last)
  end

  test "should show organization_structure" do
    get organization_structure_url(@organization_structure)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_structure_url(@organization_structure)
    assert_response :success
  end

  test "should update organization_structure" do
    patch organization_structure_url(@organization_structure), params: { organization_structure: { code: @organization_structure.code, name: @organization_structure.name, organization_structure_type_id: @organization_structure.organization_structure_type_id, parent_organization_structure_id: @organization_structure.parent_organization_structure_id } }
    assert_redirected_to organization_structure_url(@organization_structure)
  end

  test "should destroy organization_structure" do
    assert_difference('OrganizationStructure.count', -1) do
      delete organization_structure_url(@organization_structure)
    end

    assert_redirected_to organization_structures_url
  end
end
