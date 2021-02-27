class Suite < ApplicationRecord
    validates_uniqueness_of :nome, message: "Já existe uma suite com o nome inserido"
    scope :filter_by_nome_suite, -> (nome) { where nome: nome }
end
