class CreateLearningData < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_data do |t|
      t.string :learning_subject, null: false
      t.integer :time,            null: false
      t.date :date,               null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
