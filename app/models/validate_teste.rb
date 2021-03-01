class ValidateTeste
  def validate_post_teste(teste_params)
    errors = []
    params = JSON.parse(teste_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    return { error: "Deve possuir uma suite cadastrada" } unless params.include?("nome")
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
  end

  def unique_value(error)
    { error: error[:nome][0] }
  end
end