class CreateSuites < ActiveRecord::Migration[6.1]
  def change
    create_table :suites do |t|
      t.string :nome

      t.timestamps
    end
  end
end
