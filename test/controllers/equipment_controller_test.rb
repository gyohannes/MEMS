require 'test_helper'

class EquipmentControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipment = equipment(:one)
  end

  test "should get index" do
    get equipment_index_url
    assert_response :success
  end

  test "should get new" do
    get new_equipment_url
    assert_response :success
  end

  test "should create equipment" do
    assert_difference('Equipment.count') do
      post equipment_index_url, params: { equipment: { country: @equipment.country, equipment_name_id: @equipment.equipment_name_id, facility_id: @equipment.facility_id, local_representative_id: @equipment.local_representative_id, manual_attached: @equipment.manual_attached, manufactured_year: @equipment.manufactured_year, manufacturer: @equipment.manufacturer, model: @equipment.model, power_requirement: @equipment.power_requirement, purchase_price: @equipment.purchase_price, purchased_year: @equipment.purchased_year, remark: @equipment.remark, serial_number: @equipment.serial_number, status: @equipment.status, supplier_id: @equipment.supplier_id, tag_number: @equipment.tag_number, volt_ampere: @equipment.volt_ampere, warranty_agreement_note: @equipment.warranty_agreement_note } }
    end

    assert_redirected_to equipment_url(Equipment.last)
  end

  test "should show equipment" do
    get equipment_url(@equipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipment_url(@equipment)
    assert_response :success
  end

  test "should update equipment" do
    patch equipment_url(@equipment), params: { equipment: { country: @equipment.country, equipment_name_id: @equipment.equipment_name_id, facility_id: @equipment.facility_id, local_representative_id: @equipment.local_representative_id, manual_attached: @equipment.manual_attached, manufactured_year: @equipment.manufactured_year, manufacturer: @equipment.manufacturer, model: @equipment.model, power_requirement: @equipment.power_requirement, purchase_price: @equipment.purchase_price, purchased_year: @equipment.purchased_year, remark: @equipment.remark, serial_number: @equipment.serial_number, status: @equipment.status, supplier_id: @equipment.supplier_id, tag_number: @equipment.tag_number, volt_ampere: @equipment.volt_ampere, warranty_agreement_note: @equipment.warranty_agreement_note } }
    assert_redirected_to equipment_url(@equipment)
  end

  test "should destroy equipment" do
    assert_difference('Equipment.count', -1) do
      delete equipment_url(@equipment)
    end

    assert_redirected_to equipment_index_url
  end
end
