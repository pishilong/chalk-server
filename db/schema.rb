# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130810073401) do

  create_table "cities", :force => true do |t|
    t.integer  "province_id"
    t.string   "name"
    t.string   "code"
    t.string   "zcode"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cities", ["province_id"], :name => "index_cities_on_province_id"

  create_table "districts", :force => true do |t|
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "name"
    t.integer  "old_id"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"
  add_index "districts", ["province_id"], :name => "index_districts_on_province_id"

  create_table "exam_categories", :force => true do |t|
    t.string   "exam_type"
    t.string   "subject"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exam_paper_extensions", :force => true do |t|
    t.integer  "question_container_id"
    t.integer  "source_paper_id"
    t.string   "import_status"
    t.string   "process_status"
    t.string   "name"
    t.text     "description"
    t.integer  "year"
    t.integer  "month"
    t.string   "source"
    t.string   "region_type"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "paper_no"
    t.integer  "duration"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "exam_paper_extensions", ["question_container_id"], :name => "index_exam_paper_extensions_on_question_container_id"

  create_table "keypoints", :force => true do |t|
    t.integer  "exam_category_id"
    t.integer  "knowledge_id"
    t.string   "title"
    t.text     "content"
    t.integer  "order_idx"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "keypoints", ["exam_category_id"], :name => "index_keypoints_on_exam_category_id"
  add_index "keypoints", ["knowledge_id"], :name => "index_keypoints_on_knowledge_id"

  create_table "keypoints_questions", :force => true do |t|
    t.integer  "question_id"
    t.integer  "keypoint_id"
    t.integer  "order_idx"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "keypoints_questions", ["keypoint_id"], :name => "index_keypoints_questions_on_keypoint_id"
  add_index "keypoints_questions", ["question_id"], :name => "index_keypoints_questions_on_question_id"

  create_table "knowledge_containers", :force => true do |t|
    t.integer  "exam_category_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "knowledge_containers", ["exam_category_id"], :name => "index_knowledge_containers_on_exam_category_id"

  create_table "knowledge_problem_links", :force => true do |t|
    t.string   "option"
    t.integer  "knowledge_container_id"
    t.integer  "problem_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "knowledge_problem_links", ["knowledge_container_id"], :name => "index_knowledge_problem_links_on_knowledge_container_id"
  add_index "knowledge_problem_links", ["problem_id"], :name => "index_knowledge_problem_links_on_problem_id"

  create_table "knowledge_trees", :force => true do |t|
    t.integer  "exam_category_id"
    t.integer  "knowledge_container_id"
    t.string   "name"
    t.text     "content"
    t.integer  "p_id"
    t.integer  "level"
    t.integer  "order_idx"
    t.string   "overall_idx"
    t.integer  "knowledges_count"
    t.integer  "children_count"
    t.integer  "knowledge_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "knowledge_trees", ["exam_category_id"], :name => "index_knowledge_trees_on_exam_category_id"
  add_index "knowledge_trees", ["knowledge_container_id"], :name => "index_knowledge_trees_on_knowledge_container_id"
  add_index "knowledge_trees", ["knowledge_id"], :name => "index_knowledge_trees_on_knowledge_id"
  add_index "knowledge_trees", ["p_id"], :name => "index_knowledge_trees_on_p_id"

  create_table "knowledges", :force => true do |t|
    t.integer  "exam_category_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "knowledges", ["exam_category_id"], :name => "index_knowledges_on_exam_category_id"

  create_table "knowledges_questions", :force => true do |t|
    t.integer  "question_id"
    t.integer  "knowledge_id"
    t.integer  "order_idx"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "knowledges_questions", ["knowledge_id"], :name => "index_knowledges_questions_on_knowledge_id"
  add_index "knowledges_questions", ["question_id"], :name => "index_knowledges_questions_on_question_id"

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_attribute_links", :force => true do |t|
    t.text     "content"
    t.integer  "problem_id"
    t.integer  "question_attribute_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "question_attribute_links", ["problem_id"], :name => "index_question_attribute_links_on_problem_id"
  add_index "question_attribute_links", ["question_attribute_id"], :name => "index_question_attribute_links_on_question_attribute_id"

  create_table "question_attributes", :force => true do |t|
    t.string   "name"
    t.boolean  "built_in"
    t.integer  "order_idx"
    t.integer  "exam_category_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "question_attributes", ["exam_category_id"], :name => "index_question_attributes_on_exam_category_id"

  create_table "question_containers", :force => true do |t|
    t.integer  "exam_category_id"
    t.string   "source_type"
    t.string   "status"
    t.string   "forbidden_note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "question_containers", ["exam_category_id"], :name => "index_question_containers_on_exam_category_id"

  create_table "question_contents", :force => true do |t|
    t.string   "answer_type"
    t.integer  "difficulty"
    t.text     "content"
    t.text     "answer"
    t.text     "analysis"
    t.text     "fallible_point"
    t.text     "option_a"
    t.text     "option_b"
    t.text     "option_c"
    t.text     "option_d"
    t.text     "option_e"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "question_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "study_history_id"
    t.integer  "question_id"
    t.text     "answer"
    t.boolean  "correct"
    t.float    "score"
    t.boolean  "marked"
    t.boolean  "finished"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "question_histories", ["question_id"], :name => "index_question_histories_on_question_id"
  add_index "question_histories", ["study_history_id"], :name => "index_question_histories_on_study_history_id"
  add_index "question_histories", ["user_id"], :name => "index_question_histories_on_user_id"

  create_table "question_sections", :force => true do |t|
    t.integer  "exam_category_id"
    t.integer  "question_container_id"
    t.string   "section_type"
    t.integer  "p_id"
    t.integer  "level"
    t.integer  "order_idx"
    t.string   "overall_idx"
    t.integer  "questions_count"
    t.integer  "children_count"
    t.string   "title"
    t.string   "matched_title"
    t.text     "description"
    t.boolean  "virtual"
    t.integer  "question_id"
    t.text     "score"
    t.string   "number"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "question_sections", ["exam_category_id"], :name => "index_question_sections_on_exam_category_id"
  add_index "question_sections", ["question_container_id"], :name => "index_question_sections_on_question_container_id"
  add_index "question_sections", ["question_id"], :name => "index_question_sections_on_question_id"

  create_table "question_tag_links", :force => true do |t|
    t.boolean  "has_trait"
    t.boolean  "similar_condition"
    t.boolean  "similar_purpose"
    t.integer  "problem_id"
    t.integer  "question_tag_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "question_tag_links", ["problem_id"], :name => "index_question_tag_links_on_problem_id"
  add_index "question_tag_links", ["question_tag_id"], :name => "index_question_tag_links_on_question_tag_id"

  create_table "question_tag_types", :force => true do |t|
    t.string   "name"
    t.boolean  "built_in"
    t.integer  "order_idx"
    t.boolean  "has_trait"
    t.text     "sub_names"
    t.integer  "exam_category_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "question_tag_types", ["exam_category_id"], :name => "index_question_tag_types_on_exam_category_id"

  create_table "question_tags", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "level"
    t.integer  "oreder_idx"
    t.integer  "parent_id"
    t.integer  "question_tag_type_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "question_tags", ["parent_id"], :name => "index_question_tags_on_parent_id"
  add_index "question_tags", ["question_tag_type_id"], :name => "index_question_tags_on_question_tag_type_id"

  create_table "questions", :force => true do |t|
    t.integer  "exam_category_id"
    t.string   "question_type"
    t.integer  "p_id"
    t.integer  "level"
    t.integer  "order_idx"
    t.integer  "children_count"
    t.string   "number"
    t.string   "title"
    t.text     "description"
    t.text     "material"
    t.text     "options"
    t.string   "process_status"
    t.integer  "processing_user_id"
    t.datetime "processing_at"
    t.integer  "question_content_id"
    t.integer  "scope_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "questions", ["exam_category_id"], :name => "index_questions_on_exam_category_id"
  add_index "questions", ["p_id"], :name => "index_questions_on_p_id"
  add_index "questions", ["processing_user_id"], :name => "index_questions_on_processing_user_id"
  add_index "questions", ["question_content_id"], :name => "index_questions_on_question_content_id"
  add_index "questions", ["scope_id"], :name => "index_questions_on_scope_id"

  create_table "study_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "study_resorce_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "study_histories", ["study_resorce_id"], :name => "index_study_histories_on_study_resorce_id"
  add_index "study_histories", ["user_id"], :name => "index_study_histories_on_user_id"

  create_table "study_resorce_categories", :force => true do |t|
    t.integer  "exam_category_id"
    t.string   "type"
    t.string   "title"
    t.integer  "p_id"
    t.integer  "level"
    t.integer  "order_idx"
    t.integer  "study_resorces_count"
    t.integer  "children_count"
    t.integer  "study_resorce_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "study_resorce_categories", ["exam_category_id"], :name => "index_study_resorce_categories_on_exam_category_id"
  add_index "study_resorce_categories", ["p_id"], :name => "index_study_resorce_categories_on_p_id"
  add_index "study_resorce_categories", ["study_resorce_id"], :name => "index_study_resorce_categories_on_study_resorce_id"
  add_index "study_resorce_categories", ["type"], :name => "index_study_resorce_categories_on_type"

  create_table "study_resorces", :force => true do |t|
    t.integer  "exam_category_id"
    t.integer  "knowledge_id"
    t.string   "behavior_type"
    t.string   "container_type"
    t.integer  "container_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "study_resorces", ["behavior_type"], :name => "index_study_resorces_on_behavior_type"
  add_index "study_resorces", ["container_id"], :name => "index_study_resorces_on_container_id"
  add_index "study_resorces", ["container_type"], :name => "index_study_resorces_on_container_type"
  add_index "study_resorces", ["exam_category_id"], :name => "index_study_resorces_on_exam_category_id"
  add_index "study_resorces", ["knowledge_id"], :name => "index_study_resorces_on_knowledge_id"

  create_table "test_extensions", :force => true do |t|
    t.integer  "study_resorce_id"
    t.integer  "duration"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "test_extensions", ["study_resorce_id"], :name => "index_test_extensions_on_study_resorce_id"

  create_table "topic_extensions", :force => true do |t|
    t.integer  "study_resorce_category_id"
    t.text     "material"
    t.integer  "material_reader_count"
    t.integer  "comments_count"
    t.float    "average_score"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "topic_extensions", ["study_resorce_category_id"], :name => "index_topic_extensions_on_study_resorce_category_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
