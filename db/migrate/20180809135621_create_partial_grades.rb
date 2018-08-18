class CreatePartialGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :partial_grades do |t|
      t.references :user, foreign_key: {to_table: :users}, index: true
      t.text :unit
      t.text :element
      t.text :grade
      t.text :year
      t.timestamps
    end
  end
end
