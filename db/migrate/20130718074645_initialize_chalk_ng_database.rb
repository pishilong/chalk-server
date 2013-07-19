class InitializeChalkNgDatabase < ActiveRecord::Migration
  def up
    create_table :exam_categories do |t|
      t.string :exam_type
      t.string :subject

      t.timestamps
    end

    create_table :knowledge_containers do |t|
      t.integer :exam_category_id

      t.timestamps
    end

    add_index :knowledge_containers, :exam_category_id

    create_table :knowledge_trees do |t|
      t.integer :exam_category_id
      t.integer :knowledge_container_id
      t.string  :name
      t.text    :content
      t.integer :p_id
      t.integer :level
      t.integer :order_idx
      t.string  :overall_idx
      t.integer :knowledges_count
      t.integer :children_count
      t.integer :knowledge_id

      t.timestamps
    end

    add_index :knowledge_trees, :exam_category_id
    add_index :knowledge_trees, :knowledge_container_id
    add_index :knowledge_trees, :p_id
    add_index :knowledge_trees, :knowledge_id

    create_table :knowledges do |t|
      t.integer :exam_category_id
      t.string  :title
      t.text    :content

      t.timestamps
    end

    add_index :knowledges, :exam_category_id

    create_table :knowledges_questions do |t|
      t.integer :question_id
      t.integer :knowledge_id
      t.integer :order_idx

      t.timestamps
    end

    add_index :knowledges_questions, :question_id
    add_index :knowledges_questions, :knowledge_id

    create_table :keypoints do |t|
      t.integer :exam_category_id
      t.integer :knowledge_id
      t.string  :title
      t.text    :content
      t.integer :order_idx

      t.timestamps
    end

    add_index :keypoints, :exam_category_id
    add_index :keypoints, :knowledge_id

    create_table :keypoints_questions do |t|
      t.integer :question_id
      t.integer :keypoint_id
      t.integer :order_idx

      t.timestamps
    end

    add_index :keypoints_questions, :question_id
    add_index :keypoints_questions, :keypoint_id

    create_table :question_containers do |t|
      t.integer :exam_category_id
      t.string  :source_type
      t.string  :status
      t.string  :forbidden_note

      t.timestamps
    end

    add_index :question_containers, :exam_category_id

    create_table :exam_paper_extensions do |t|
      t.integer :question_container_id
      t.integer :source_paper_id
      t.string  :import_status
      t.string  :process_status
      t.string  :name
      t.text    :description
      t.integer :year
      t.integer :month
      t.string  :source
      t.string  :region_type
      t.integer :province_id
      t.integer :city_id
      t.integer :district_id
      t.string  :paper_no
      t.integer :duration

      t.timestamps
    end

    add_index :exam_paper_extensions, :question_container_id

    create_table :question_sections do |t|
      t.integer :exam_category_id
      t.integer :question_container_id
      t.string  :section_type
      t.integer :p_id
      t.integer :level
      t.integer :order_idx
      t.string  :overall_idx
      t.integer :questions_count
      t.integer :children_count
      t.string  :title
      t.string  :matched_title
      t.text    :description
      t.boolean :virtual
      t.integer :question_id
      t.text    :score
      t.string  :number

      t.timestamps
    end

    add_index :question_sections, :exam_category_id
    add_index :question_sections, :question_container_id
    add_index :question_sections, :question_id

    create_table :questions do |t|
      t.integer  :exam_category_id
      t.string   :question_type
      t.integer  :p_id
      t.integer  :level
      t.integer  :order_idx
      t.integer  :children_count
      t.string   :number
      t.string   :title
      t.text     :description
      t.text     :material
      t.text     :options
      t.string   :process_status
      t.integer  :processing_user_id
      t.datetime :processing_at
      t.integer  :question_content_id
      t.integer  :scope_id

      t.timestamps
    end

    add_index :questions, :exam_category_id
    add_index :questions, :p_id
    add_index :questions, :question_content_id
    add_index :questions, :scope_id
    add_index :questions, :processing_user_id

    create_table :question_contents do |t|
      t.string  :answer_type
      t.integer :difficulty
      t.text    :content
      t.text    :answer
      t.text    :analysis
      t.text    :fallible_point
      t.text    :option_a
      t.text    :option_b
      t.text    :option_c
      t.text    :option_d
      t.text    :option_e

      t.timestamps
    end

    create_table :study_resorce_categories do |t|
      t.integer  :exam_category_id
      t.string   :type
      t.string   :title
      t.integer  :p_id
      t.integer  :level
      t.integer  :order_idx
      t.integer  :study_resorces_count
      t.integer  :children_count
      t.integer  :study_resorce_id

      t.timestamps
    end

    add_index :study_resorce_categories, :exam_category_id
    add_index :study_resorce_categories, :type
    add_index :study_resorce_categories, :p_id
    add_index :study_resorce_categories, :study_resorce_id

    create_table :topic_extensions do |t|
      t.integer :study_resorce_category_id
      t.text    :material
      t.integer :material_reader_count
      t.integer :comments_count
      t.float   :average_score

      t.timestamps
    end

    add_index :topic_extensions, :study_resorce_category_id

    create_table :study_resorces do |t|
      t.integer :exam_category_id
      t.integer :knowledge_id
      t.string  :behavior_type
      t.string  :container_type
      t.integer :container_id
      t.string  :title
      t.text    :description

      t.timestamps
    end

    add_index :study_resorces, :exam_category_id
    add_index :study_resorces, :knowledge_id
    add_index :study_resorces, :behavior_type
    add_index :study_resorces, :container_type
    add_index :study_resorces, :container_id

    create_table :test_extensions do |t|
      t.integer :study_resorce_id
      t.integer :duration

      t.timestamps
    end

    add_index :test_extensions, :study_resorce_id

    create_table :study_histories do |t|
      t.integer :user_id
      t.integer :study_resorce_id

      t.timestamps
    end

    add_index :study_histories, :user_id
    add_index :study_histories, :study_resorce_id

    create_table :question_histories do |t|
      t.integer :user_id
      t.integer :study_history_id
      t.integer :question_id
      t.text    :answer
      t.boolean :correct
      t.float   :score
      t.boolean :marked
      t.boolean :finished

      t.timestamps
    end

    add_index :question_histories, :user_id
    add_index :question_histories, :study_history_id
    add_index :question_histories, :question_id

    create_table :provinces do |t|
      t.string   :name
      t.string   :code

      t.timestamps
    end

    create_table :cities do |t|
      t.integer  :province_id
      t.string   :name
      t.string   :code
      t.string   :zcode

      t.timestamps
    end

    add_index :cities, :province_id

    create_table :districts do |t|
      t.integer  :province_id
      t.integer  :city_id
      t.string   :name
      t.integer  :old_id
      t.string   :code

      t.timestamps
    end

    add_index :districts, :province_id
    add_index :districts, :city_id
  end

  def down
    raise "can not down"
  end
end
