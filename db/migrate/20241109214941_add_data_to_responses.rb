class AddDataToResponses < ActiveRecord::Migration[7.2]
  def change
    add_column :responses, :data, :jsonb
  end
end
