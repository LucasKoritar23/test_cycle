class Teste < ApplicationRecord
  belongs_to :suite
  validates_uniqueness_of :nome, message: "Já existe um teste com o nome inserido"
  scope :filter_by_nome_teste, -> (nome) { where nome: nome }
end
