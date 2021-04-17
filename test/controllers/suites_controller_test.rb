require "test_helper"

class SuitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suite = suites(:one)
  end

  test "should get index" do
    get suites_url, as: :json
    assert_response :success
  end

  test "should create suite" do
    assert_difference('Suite.count') do
      post suites_url, params: { suite: { nome: @suite.nome } }, as: :json
    end

    assert_response 201
  end

  test "should show suite" do
    get suite_url(@suite), as: :json
    assert_response :success
  end

  test "should update suite" do
    patch suite_url(@suite), params: { suite: { nome: @suite.nome } }, as: :json
    assert_response 200
  end

  test "should destroy suite" do
    assert_difference('Suite.count', -1) do
      delete suite_url(@suite), as: :json
    end

    assert_response 204
  end
end
