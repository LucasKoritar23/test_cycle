require "test_helper"

class TestesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testis = testes(:one)
  end

  test "should get index" do
    get testes_url, as: :json
    assert_response :success
  end

  test "should create testis" do
    assert_difference('Teste.count') do
      post testes_url, params: { testis: { nome: @testis.nome, suite_id: @testis.suite_id } }, as: :json
    end

    assert_response 201
  end

  test "should show testis" do
    get testis_url(@testis), as: :json
    assert_response :success
  end

  test "should update testis" do
    patch testis_url(@testis), params: { testis: { nome: @testis.nome, suite_id: @testis.suite_id } }, as: :json
    assert_response 200
  end

  test "should destroy testis" do
    assert_difference('Teste.count', -1) do
      delete testis_url(@testis), as: :json
    end

    assert_response 204
  end
end
