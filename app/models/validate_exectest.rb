class ValidateExectest
  def validate_post_exectest(exectest_params)
    errors = []
    params = JSON.parse(exectest_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?

    qa_id = params["qa_id"]
    suite_id = params["suite_id"]
    teste_id = params["teste_id"]

    return { error: "Deve possuir o campo qa_id" } if qa_id.nil? or qa_id == ""
    return { error: "Deve possuir o campo suite_id" } if suite_id.nil? or suite_id == ""
    return { error: "Deve possuir o campo teste_id" } if teste_id.nil? or teste_id == ""

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

  def validate_put_exectest(exectest_params, exectest)
    errors = []
    params = JSON.parse(exectest_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?

    finish = exec_finish_test(exectest)
    return { error: "O teste já foi finalizado" } if finish > 0

    status = exectest_params["status"]

    if status.nil?
      errors << { error: "status não pode ser nulo" }
    elsif status.class != String
      errors << { error: "status deve ser String" }
    elsif status == ""
      errors << { error: "status não pode ser em branco" }
    elsif status.length > 256
      errors << { error: "status não pode ser maior que 256 números" }
    end

    return errors if errors != []

    valid_status = %w[BLOCKED FAILED SUCCESS]
    
    valid_status.each do |key|
      if status == key
        @status = true
        break
      end
    end

    return { error: "O status inserido não é valido, status validos: #{valid_status}" } if @status.nil?

    errors
  end

  def exec_finish_test(exectest)
    id = exectest.id
    query = "SELECT count(data_fim) as finished FROM exectests WHERE id = '#{id}' and data_fim is not null;"

    if ENV["RAILS_ENV"] == "development"
      db = SQLite3::Database.open "db/development.sqlite3"
      db.results_as_hash = true

      result_query_count = db.execute(query)
      db.close if db
    else
      conn = PG.connect(ENV["DATABASE_URL"])
      run_query = conn.exec(query)
      total_lines = run_query.count
      result_query_count = []
      total_lines.times do |line|
        result_query_count << run_query[line]
      end
      conn.close
    end

    result_query_count[0]["finished"]
  end

  def exec_already_test(exectest_params)
    error = []
    qa_id = exectest_params["qa_id"]
    suite_id = exectest_params["suite_id"]
    teste_id = exectest_params["teste_id"]

    query = "SELECT count(*) as total_in_progress FROM exectests WHERE qa_id = #{qa_id} "
    query += "AND suite_id = #{suite_id} AND teste_id = #{teste_id} AND status = 'IN_PROGRESS'"

    if ENV["RAILS_ENV"] == "development"
      db = SQLite3::Database.open "db/development.sqlite3"
      db.results_as_hash = true
      result_query_count = db.execute(query)
      db.close if db
    else
      conn = PG.connect(ENV["DATABASE_URL"])
      run_query = conn.exec(query)
      total_lines = run_query.count
      result_query_count = []
      total_lines.times do |line|
        result_query_count << run_query[line]
      end
      conn.close
    end

    total_in_progress = result_query_count[0]["total_in_progress"]

    if total_in_progress > 0
      query = "SELECT * FROM exectests WHERE qa_id = #{qa_id} "
      query += "AND suite_id = #{suite_id} AND teste_id = #{teste_id} AND status = 'IN_PROGRESS'"

      if ENV["RAILS_ENV"] == "development"
        db = SQLite3::Database.open "db/development.sqlite3"
        db.results_as_hash = true
        result_query = db.execute(query)
        db.close if db
      else
        conn = PG.connect(ENV["DATABASE_URL"])
        run_query = conn.exec(query)
        total_lines = run_query.count
        result_query = []
        total_lines.times do |line|
          result_query << run_query[line]
        end
        conn.close
      end

      error << { error: "Já existem execuções ativas deste teste", test: JSON.parse(result_query.to_json) }
    end

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