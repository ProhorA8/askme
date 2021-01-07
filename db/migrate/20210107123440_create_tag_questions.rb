class CreateTagQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_questions do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
