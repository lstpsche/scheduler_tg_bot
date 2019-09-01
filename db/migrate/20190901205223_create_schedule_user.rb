class CreateScheduleUser < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_users do |t|
      t.belongs_to :user
      t.belongs_to :schedule

      t.timestamps
    end
  end
end
