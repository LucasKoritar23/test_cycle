class Exectest < ApplicationRecord
  belongs_to :qa
  belongs_to :suite
  belongs_to :teste
end
