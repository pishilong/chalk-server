class CreateQuestionTagTypes < ActiveRecord::Migration
  def change
    create_table :question_tag_types do |t|
      t.string :name
      t.boolean :built_in
      t.integer :order_idx
      t.boolean :has_trait
      t.text :sub_names
      t.references :exam_category

      t.timestamps
    end
    add_index :question_tag_types, :exam_category_id
  end
end
