class AddFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :fields, :jsonb
  end
end
