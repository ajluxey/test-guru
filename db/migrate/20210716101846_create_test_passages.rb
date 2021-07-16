class CreateTestPassages < ActiveRecord::Migration[6.1]
  def change
    create_table :test_passages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.references :current_question, foreign_key: false
      t.integer :correct_questions, null: false, default: 0

      t.timestamps
    end
    add_foreign_key :test_passages, :questions, column: :current_question_id
  end
end
