class CreateQas < ActiveRecord::Migration[6.1]
  def change
    create_table :qas do |t|
      t.string :nome
      t.string :tribo
      t.string :squad

      t.timestamps
    end
  end
end
