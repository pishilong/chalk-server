class CreateKnowledgeProblemLinks < ActiveRecord::Migration
  def change
    create_table :knowledge_problem_links do |t|
      t.string :option
      t.references :knowledge_container
      t.references :problem

      t.timestamps
    end
    add_index :knowledge_problem_links, :problem_id
    add_index :knowledge_problem_links, :knowledge_container_id
  end
end
