class Qa < ApplicationRecord
  validates_uniqueness_of :nome, message: "Já existe um QA com o nome inserido"

  def validate_params(qa_params)
    error = nil
    params = JSON.parse(qa_params.to_json)
    return { error: "Deve possuir um JSON", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] } if params == {} or params == "{}" or params.nil?
    return { error: "Deve possuir o campo Nome", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] } unless params.include?("nome")
    name = params["nome"]

    if name.nil?
      error = { error: "Nome não pode ser nulo", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
    elsif name.class != String
      error = { error: "Nome deve ser string", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
    elsif name.empty?
      error = { error: "Nome não pode ser em branco", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
    elsif name.length < 3 or name.length > 200
      error = { error: "Nome deve conter entre 3 e 200 caracteres", code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
    end
    error
  end

  def unique_value(error)
    { error: error[:nome][0], code: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
  end
end