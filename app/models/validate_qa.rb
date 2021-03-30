class ValidateQa
  def validate_post_qa(qa_params)
    errors = []
    params = JSON.parse(qa_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome" } unless params.include?("nome")
    name = params["nome"]
    tribo = params["tribo"]
    squad = params["squad"]

    if name.nil?
      errors << { error: "Nome não pode ser nulo" }
    elsif name.class != String
      errors << { error: "Nome deve ser string" }
    elsif name.empty?
      errors << { error: "Nome não pode ser em branco" }
    elsif name.length < 3 or name.length > 200
      errors << { error: "Nome deve conter entre 3 e 200 caracteres" }
    end

    if params.include?("tribo")
      if tribo.class != String
        errors << { error: "Tribo deve ser string" }
      elsif tribo.empty?
        errors << { error: "Tribo não pode ser em branco" }
      elsif tribo.length < 3 or tribo.length > 200
        errors << { error: "Tribo deve conter entre 3 e 200 caracteres" }
      end
    end

    if params.include?("squad")
      if squad.class != String
        errors << { error: "Squad deve ser string" }
      elsif squad.empty?
        errors << { error: "Squad não pode ser em branco" }
      elsif squad.length < 3 or squad.length > 200
        errors << { error: "Squad deve conter entre 3 e 200 caracteres" }
      end
    end

    errors
  end

  def validate_edit_qa(qa_params)
    errors = []
    params = JSON.parse(qa_params.to_json)
    return { error: "Deve possuir um JSON" } if params == {} or params == "{}" or params.nil?
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