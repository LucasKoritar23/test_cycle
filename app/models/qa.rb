class Qa < ApplicationRecord
  validates_uniqueness_of :nome, message: "Já existe um QA com o nome inserido"
  scope :filter_by_nome_qa, -> (nome) { where nome: nome }
end