class CreateWeekDays < ActiveRecord::Migration
  def change
    create_table :week_days do |t|
      t.string :name

      t.timestamps
    end
  end
end
