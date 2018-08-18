class CreateFinalGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :final_grades do |t|
      t.references :user, foreign_key: {to_table: :users}, index: true
      t.text :unit
      t.text :epoch
      t.text :oral_ex
      t.text :write_ex
      t.text :consultation_date
      t.text :oral_date
      t.text :grade
      t.timestamps
    end
  end
end
