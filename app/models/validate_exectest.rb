class ValidateExectest

  def validate_post_exectest(exectest_params)
    errors = []
    params = JSON.parse(exectest_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?

    qa_id = params["qa_id"]
    suite_id = params["suite_id"]
    teste_id = params["teste_id"]

    if qa_id.nil?
      errors << { error: "qa_id não pode ser nulo" }
    elsif qa_id.class != Integer
      errors << { error: "qa_id deve ser Inteiro" }
    elsif qa_id == ""
      errors << { error: "qa_id não pode ser em branco" }
    elsif qa_id == 0
      errors << { error: "qa_id não pode ser zero" }
    elsif qa_id.to_s.length > 256
      errors << { error: "qa_id não pode ser maior que 256 números" }
    end

    if suite_id.nil?
      errors << { error: "suite_id não pode ser nulo" }
    elsif suite_id.class != Integer
      errors << { error: "suite_id deve ser Inteiro" }
    elsif suite_id == ""
      errors << { error: "suite_id não pode ser em branco" }
    elsif suite_id == 0
      errors << { error: "suite_id não pode ser zero" }
    elsif suite_id.to_s.length > 256
      errors << { error: "suite_id não pode ser maior que 256 números" }
    end

    if teste_id.nil?
      errors << { error: "teste_id não pode ser nulo" }
    elsif teste_id.class != Integer
      errors << { error: "teste_id deve ser Inteiro" }
    elsif teste_id == ""
      errors << { error: "teste_id não pode ser em branco" }
    elsif teste_id == 0
      errors << { error: "teste_id não pode ser zero" }
    elsif teste_id.to_s.length > 256
      errors << { error: "teste_id não pode ser maior que 256 números" }
    end

    errors
  end

  def exec_already_test(exectest_params)
    error = []
    qa_id = exectest_params["qa_id"]
    suite_id = exectest_params["suite_id"]
    teste_id = exectest_params["teste_id"]

    return { error: "Deve possuir o campo qa_id" } if qa_id.nil? or qa_id == ""
    return { error: "Deve possuir o campo suite_id" } if suite_id.nil? or suite_id == ""
    return { error: "Deve possuir o campo teste_id" } if teste_id.nil? or teste_id == ""

    db = SQLite3::Database.open "db/development.sqlite3"
    db.results_as_hash = true
    query = "SELECT * FROM exectests WHERE qa_id = #{qa_id} "
    query += "AND suite_id = #{suite_id} AND teste_id = #{teste_id} AND status = 'IN_PROGRESS'"
    result_query = db.execute(query)
    error << { error: "Já existem execuções ativas deste teste", test: JSON.parse(result_query.to_json) } unless result_query == []
    db.close if db

    error
  end

  def unique_value(error)
    object = error.messages.keys
    error = error.messages.values
    if object == [:qa] and error[0][0] == "must exist"
      message_send = "Não existe um qa com o id informado"
    elsif object == [:suite] and error[0][0] == "must exist"
      message_send = "Não existe uma suite com o id informado"
    elsif object == [:teste] and error[0][0] == "must exist"
      message_send = "Não existe um teste com o id informado"
    elsif object == [:qa, :suite, :teste]
      message_send = ["Não existe um qa com o id informado", "Não existe um teste com o id informado", "Não existe uma suite com o id informado"]
    else
      message_send = "Inconsistências no payload enviado"
    end

    { error: message_send }
  end
end