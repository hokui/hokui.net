class CreateSemestersSubjects < ActiveRecord::Migration
  def change
    create_table :semesters_subjects, id: false do |t|
      t.integer :semester_id, null: false
      t.integer :subject_id,  null: false
    end

    add_index :semesters_subjects, [:semester_id, :subject_id], unique: true
  end
end
