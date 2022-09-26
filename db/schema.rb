# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_26_101002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_teachers", force: :cascade do |t|
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "email"
  end

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "step_id", null: false
    t.string "answer_type"
    t.index ["step_id"], name: "index_answers_on_step_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "answer_id", null: false
    t.index ["answer_id"], name: "index_feedbacks_on_answer_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "extern_joins_points"
    t.integer "forces_moments_points"
    t.integer "con_rod_points"
    t.integer "ball_joint_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_teacher_id", null: false
    t.bigint "structure_id", null: false
    t.index ["admin_teacher_id"], name: "index_problems_on_admin_teacher_id"
    t.index ["structure_id"], name: "index_problems_on_structure_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "step_id", null: false
    t.index ["step_id"], name: "index_responses_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "problem_id", null: false
    t.string "step_type"
    t.index ["problem_id"], name: "index_steps_on_problem_id"
  end

  create_table "structures", force: :cascade do |t|
    t.string "moment_reference"
    t.string "nodes_list"
    t.string "segments_list"
    t.string "struct_link"
    t.string "force_values"
    t.string "moment_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_teacher_id", null: false
    t.index ["admin_teacher_id"], name: "index_structures_on_admin_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "full_name"
    t.integer "extern_joins_stat"
    t.integer "forces_moments_stat"
    t.integer "con_rod_stat"
    t.integer "ball_joint_stat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "extern_joins_exp"
    t.integer "forces_moments_exp"
    t.integer "con_rod_exp"
    t.integer "ball_joint_exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "problem_id", null: false
    t.bigint "student_id", null: false
    t.index ["problem_id"], name: "index_tasks_on_problem_id"
    t.index ["student_id"], name: "index_tasks_on_student_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "steps"
  add_foreign_key "feedbacks", "answers"
  add_foreign_key "problems", "admin_teachers"
  add_foreign_key "problems", "structures"
  add_foreign_key "responses", "steps"
  add_foreign_key "steps", "problems"
  add_foreign_key "structures", "admin_teachers"
  add_foreign_key "tasks", "problems"
  add_foreign_key "tasks", "students"
end
