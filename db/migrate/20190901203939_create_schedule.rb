class CreateSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
