class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.time :from
      t.time :to
      t.references :place, index: true

      t.timestamps
    end

    create_table :opening_hours_week_days do |t|
        t.belongs_to :opening_hour
        t.belongs_to :week_day
    end

    add_index :opening_hours_week_days, [:opening_hour_id, :week_day_id], unique: true,
                                        name: 'opening_hour_week_day_index'
  end
end
