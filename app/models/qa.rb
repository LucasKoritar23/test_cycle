class Qa < ApplicationRecord
  validates_uniqueness_of :nome, message: "Já existe um QA com o nome inserido"
end