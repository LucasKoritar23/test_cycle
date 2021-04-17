class CreateExectests < ActiveRecord::Migration[6.1]
  def change
    create_table :exectests do |t|
      t.references :qa, null: false, foreign_key: true
      t.references :suite, null: false, foreign_key: true
      t.references :teste, null: false, foreign_key: true
      t.string :execucao_uuid
      t.string :data_inicio
      t.string :data_fim
      t.string :status
      t.string :evidencia
      t.string :comentario

      t.timestamps
    end
  end
end
