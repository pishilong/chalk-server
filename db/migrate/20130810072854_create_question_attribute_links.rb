class CreateQuestionAttributeLinks < ActiveRecord::Migration
  def change
    create_table :question_attribute_links do |t|
      t.text :content
      t.references :problem
      t.references :question_attribute

      t.timestamps
    end
    add_index :question_attribute_links, :problem_id
    add_index :question_attribute_links, :question_attribute_id
  end
end
