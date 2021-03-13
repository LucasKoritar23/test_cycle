class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.references :suite, null: false, foreign_key: true
      t.references :teste, null: false, foreign_key: true
      t.string :nome

      t.timestamps
    end
  end
end
