require 'test_helper'

class InstitutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @institution = institutions(:one)
  end

  test "should get index" do
    get institutions_url
    assert_response :success
  end

  test "should get new" do
    get new_institution_url
    assert_response :success
  end

  test "should create institution" do
    assert_difference('Institution.count') do
      post institutions_url, params: { institution: { category: @institution.category, institution_type: @institution.institution_type, name: @institution.name, organization_structure_id: @institution.organization_structure_id } }
    end

    assert_redirected_to institution_url(Institution.last)
  end

  test "should show institution" do
    get institution_url(@institution)
    assert_response :success
  end

  test "should get edit" do
    get edit_institution_url(@institution)
    assert_response :success
  end

  test "should update institution" do
    patch institution_url(@institution), params: { institution: { category: @institution.category, institution_type: @institution.institution_type, name: @institution.name, organization_structure_id: @institution.organization_structure_id } }
    assert_redirected_to institution_url(@institution)
  end

  test "should destroy institution" do
    assert_difference('Institution.count', -1) do
      delete institution_url(@institution)
    end

    assert_redirected_to institutions_url
  end
end
