class Step < ApplicationRecord
  belongs_to :suite
  belongs_to :teste

  validates_uniqueness_of :nome, message: "Já existe um step com o nome inserido"
  scope :filter_by_nome_step, -> (nome) { where nome: nome }
  scope :filter_by_suite_id, -> (suite_id) { where suite_id: suite_id }
  scope :filter_by_teste_id, -> (teste_id) { where teste_id: teste_id }
end
