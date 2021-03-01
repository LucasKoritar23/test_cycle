class ValidateTeste
  def validate_post_teste(teste_params)
    errors = []
    params = JSON.parse(teste_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    return { error: "Deve possuir uma suite cadastrada" } unless params.include?("nome")
    name = params["nome"]
    suite = params["suite_id"]

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
      suite << { error: "suite_id deve ser inteiro" }
    elsif suite.to_s.empty?
      errors << { error: "suite_id não pode ser em branco" }
    elsif suite == 0
      errors << { error: "suite_id não pode ser zero" }
    elsif suite.to_s.length > 256
      errors << { error: "suite_id não pode ser maior que 256 numeros" }
    end

    errors
  end

  def validate_edit_teste(teste_params)
    errors = []
    params = JSON.parse(teste_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    name = params["nome"]

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
      suite << { error: "suite_id deve ser inteiro" }
    elsif suite.to_s.empty?
      errors << { error: "suite_id não pode ser em branco" }
    elsif suite == 0
      errors << { error: "suite_id não pode ser zero" }
    elsif suite.to_s.length > 256
      errors << { error: "suite_id não pode ser maior que 256 numeros" }
    end
  end

  def unique_value(error)
    current_message = error.messages[:suite][0]
    new_message = "Não existe uma suite com o id informado" if current_message == "must exist"
    { error: new_message }
  end
end