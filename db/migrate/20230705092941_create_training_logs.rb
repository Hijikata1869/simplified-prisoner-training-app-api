class CreateTrainingLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :training_logs do |t|
      t.references :user, foreign_key: true
      t.string :training_menu, null: false
      t.string :step, null: false
      t.string :repetition, null: false
      t.string :set, null: false
      t.string :memo
      t.timestamps
    end
  end
end
