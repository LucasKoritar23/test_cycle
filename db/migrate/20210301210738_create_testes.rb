class CreateTestes < ActiveRecord::Migration[6.1]
  def change
    create_table :testes do |t|
      t.references :suite, null: false, foreign_key: true
      t.string :nome

      t.timestamps
    end
  end
end
