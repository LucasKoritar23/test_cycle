require "test_helper"

class ExectestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exectest = exectests(:one)
  end

  test "should get index" do
    get exectests_url, as: :json
    assert_response :success
  end

  test "should create exectest" do
    assert_difference('Exectest.count') do
      post exectests_url, params: { exectest: { comentario: @exectest.comentario, data_fim: @exectest.data_fim, data_inicio: @exectest.data_inicio, evidencia: @exectest.evidencia, execucao_uuid: @exectest.execucao_uuid, qa_id: @exectest.qa_id, status: @exectest.status, suite_id: @exectest.suite_id, teste_id: @exectest.teste_id } }, as: :json
    end

    assert_response 201
  end

  test "should show exectest" do
    get exectest_url(@exectest), as: :json
    assert_response :success
  end

  test "should update exectest" do
    patch exectest_url(@exectest), params: { exectest: { comentario: @exectest.comentario, data_fim: @exectest.data_fim, data_inicio: @exectest.data_inicio, evidencia: @exectest.evidencia, execucao_uuid: @exectest.execucao_uuid, qa_id: @exectest.qa_id, status: @exectest.status, suite_id: @exectest.suite_id, teste_id: @exectest.teste_id } }, as: :json
    assert_response 200
  end

  test "should destroy exectest" do
    assert_difference('Exectest.count', -1) do
      delete exectest_url(@exectest), as: :json
    end

    assert_response 204
  end
end
