require 'test_helper'

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training = trainings(:one)
  end

  test "should get index" do
    get trainings_url
    assert_response :success
  end

  test "should get new" do
    get new_training_url
    assert_response :success
  end

  test "should create training" do
    assert_difference('Training.count') do
      post trainings_url, params: { training: { contact_id: @training.contact_id, equipment_name_id: @training.equipment_name_id, model: @training.model, trainer_name: @training.trainer_name, training_date: @training.training_date, training_sponsor: @training.training_sponsor, training_type: @training.training_type } }
    end

    assert_redirected_to training_url(Training.last)
  end

  test "should show training" do
    get training_url(@training)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_url(@training)
    assert_response :success
  end

  test "should update training" do
    patch training_url(@training), params: { training: { contact_id: @training.contact_id, equipment_name_id: @training.equipment_name_id, model: @training.model, trainer_name: @training.trainer_name, training_date: @training.training_date, training_sponsor: @training.training_sponsor, training_type: @training.training_type } }
    assert_redirected_to training_url(@training)
  end

  test "should destroy training" do
    assert_difference('Training.count', -1) do
      delete training_url(@training)
    end

    assert_redirected_to trainings_url
  end
end
