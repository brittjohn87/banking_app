class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string :object_name
      t.integer :object_id
      t.string :attribute_name
      t.string :before_value
      t.string :after_value

      t.timestamps
    end
  end
end
