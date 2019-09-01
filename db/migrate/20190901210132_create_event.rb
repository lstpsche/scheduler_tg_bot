class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :weekday, null: false
      t.string :time, null: false
      t.string :info, null: false
      t.belongs_to :schedule

      t.timestamps
    end
  end
end
