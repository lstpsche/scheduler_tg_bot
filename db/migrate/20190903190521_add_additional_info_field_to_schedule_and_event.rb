class AddAdditionalInfoFieldToScheduleAndEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :additional_info, :string
    add_column :events, :additional_info, :string
  end
end
