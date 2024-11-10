class CreateFields < ActiveRecord::Migration[7.2]
  def change
    create_table :fields do |t|
      t.references :post, null: false, foreign_key: true
      t.string :field_type
      t.string :label
      t.text :options

      t.timestamps
    end
  end
end
