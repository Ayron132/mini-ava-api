class AddUserIdToClassrooms < ActiveRecord::Migration[7.2]
  def change
    add_column :classrooms, :user_id, :integer
    add_index :classrooms, :user_id 
  end
end
