class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.string :name
      t.text :content
      t.integer :level
      t.integer :oreder_idx
      t.references :parent
      t.references :question_tag_type

      t.timestamps
    end
    add_index :question_tags, :parent_id
    add_index :question_tags, :question_tag_type_id
  end
end
