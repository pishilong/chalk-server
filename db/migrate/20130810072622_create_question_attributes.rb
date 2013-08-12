class CreateQuestionAttributes < ActiveRecord::Migration
  def change
    create_table :question_attributes do |t|
      t.string :name
      t.boolean :built_in
      t.integer :order_idx
      t.references :exam_category

      t.timestamps
    end
    add_index :question_attributes, :exam_category_id
  end
end
