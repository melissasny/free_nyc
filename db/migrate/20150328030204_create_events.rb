class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.string :borough
      t.string :days_of_week
      t.string :end_date
      t.string :start_date
      t.string :start_time
      t.string :website
      t.references :category

      t.timestamps
    end
    add_index :events, :category_id
  end
end
