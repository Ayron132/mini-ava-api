class CreateClassrooms < ActiveRecord::Migration[7.2]
  def change
    create_table :classrooms do |t|
      t.string :title
      t.text :description
      t.string :code

      t.timestamps
    end
  end
end
