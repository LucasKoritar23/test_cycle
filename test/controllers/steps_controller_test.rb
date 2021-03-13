require "test_helper"

class StepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @step = steps(:one)
  end

  test "should get index" do
    get steps_url, as: :json
    assert_response :success
  end

  test "should create step" do
    assert_difference('Step.count') do
      post steps_url, params: { step: { nome: @step.nome, suite_id: @step.suite_id, teste_id: @step.teste_id } }, as: :json
    end

    assert_response 201
  end

  test "should show step" do
    get step_url(@step), as: :json
    assert_response :success
  end

  test "should update step" do
    patch step_url(@step), params: { step: { nome: @step.nome, suite_id: @step.suite_id, teste_id: @step.teste_id } }, as: :json
    assert_response 200
  end

  test "should destroy step" do
    assert_difference('Step.count', -1) do
      delete step_url(@step), as: :json
    end

    assert_response 204
  end
end
