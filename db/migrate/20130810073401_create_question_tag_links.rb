class CreateQuestionTagLinks < ActiveRecord::Migration
  def change
    create_table :question_tag_links do |t|
      t.boolean :has_trait
      t.boolean :similar_condition
      t.boolean :similar_purpose
      t.references :problem
      t.references :question_tag

      t.timestamps
    end
    add_index :question_tag_links, :problem_id
    add_index :question_tag_links, :question_tag_id
  end
end
