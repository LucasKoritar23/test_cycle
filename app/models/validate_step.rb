class ValidateStep
  def validate_post_step(step_params)
    errors = []
    params = JSON.parse(step_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    return { error: "Deve possuir uma suite cadastrada" } unless params.include?("nome")
    name = params["nome"]
    suite = params["suite_id"]
    teste = params["teste_id"]

    if name.nil?
      errors << { error: "Nome não pode ser nulo" }
    elsif name.class != String
      errors << { error: "Nome deve ser string" }
    elsif name.empty?
      errors << { error: "Nome não pode ser em branco" }
    elsif name.length < 3 or name.length > 200
      errors << { error: "Nome deve conter entre 3 e 200 caracteres" }
    end

    errors

    if suite.nil?
      errors << { error: "suite_id não pode ser nulo" }
    elsif suite.class != Integer
      errors << { error: "suite_id deve ser inteiro" }
    elsif suite.to_s.empty?
      errors << { error: "suite_id não pode ser em branco" }
    elsif suite == 0
      errors << { error: "suite_id não pode ser zero" }
    elsif suite.to_s.length > 256
      errors << { error: "suite_id não pode ser maior que 256 numeros" }
    end

    errors

    if teste.nil?
      errors << { error: "teste_id não pode ser nulo" }
    elsif teste.class != Integer
      errors << { error: "teste_id deve ser inteiro" }
    elsif teste.to_s.empty?
      errors << { error: "teste_id não pode ser em branco" }
    elsif teste == 0
      errors << { error: "teste_id não pode ser zero" }
    elsif teste.to_s.length > 256
      errors << { error: "teste_id não pode ser maior que 256 numeros" }
    end

    errors
  end

  def validate_edit_step(step_params)
    errors = []
    params = JSON.parse(step_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    return { error: "Deve possuir uma suite cadastrada" } unless params.include?("nome")
    name = params["nome"]
    suite = params["suite_id"]
    teste = params["teste_id"]

    if name.nil?
      errors << { error: "Nome não pode ser nulo" }
    elsif name.class != String
      errors << { error: "Nome deve ser string" }
    elsif name.empty?
      errors << { error: "Nome não pode ser em branco" }
    elsif name.length < 3 or name.length > 200
      errors << { error: "Nome deve conter entre 3 e 200 caracteres" }
    end

    errors

    if suite.nil?
      errors << { error: "suite_id não pode ser nulo" }
    elsif suite.class != Integer
      errors << { error: "suite_id deve ser inteiro" }
    elsif suite.to_s.empty?
      errors << { error: "suite_id não pode ser em branco" }
    elsif suite == 0
      errors << { error: "suite_id não pode ser zero" }
    elsif suite.to_s.length > 256
      errors << { error: "suite_id não pode ser maior que 256 numeros" }
    end

    errors

    if teste.nil?
      errors << { error: "teste_id não pode ser nulo" }
    elsif suite.class != Integer
      errors << { error: "teste_id deve ser inteiro" }
    elsif suite.to_s.empty?
      errors << { error: "teste_id não pode ser em branco" }
    elsif suite == 0
      errors << { error: "teste_id não pode ser zero" }
    elsif suite.to_s.length > 256
      errors << { error: "teste_id não pode ser maior que 256 numeros" }
    end

    errors
  end

  def unique_value(error)
    object = error.messages.keys
    error = error.messages.values
    if object == [:teste] and error[0][0] == "must exist"
      message_send = "Não existe um teste com o id informado"
    elsif object == [:suite] and error[0][0] == "must exist"
      message_send = "Não existe uma suite com o id informado"
    elsif object == [:suite, :teste]
      message_send = ["Não existe um teste com o id informado", "Não existe uma suite com o id informado"]
    else
      message_send = "Inconsistências no payload enviado"
    end

    { error: message_send }
  end
end