require "test_helper"

class QasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qa = qas(:one)
  end

  test "should get index" do
    get qas_url, as: :json
    assert_response :success
  end

  test "should create qa" do
    assert_difference('Qa.count') do
      post qas_url, params: { qa: { id: @qa.id, nome: @qa.nome, squad: @qa.squad, tribo: @qa.tribo } }, as: :json
    end

    assert_response 201
  end

  test "should show qa" do
    get qa_url(@qa), as: :json
    assert_response :success
  end

  test "should update qa" do
    patch qa_url(@qa), params: { qa: { id: @qa.id, nome: @qa.nome, squad: @qa.squad, tribo: @qa.tribo } }, as: :json
    assert_response 200
  end

  test "should destroy qa" do
    assert_difference('Qa.count', -1) do
      delete qa_url(@qa), as: :json
    end

    assert_response 204
  end
end
