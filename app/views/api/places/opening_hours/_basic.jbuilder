json.days opening_hour.week_days, :name
json.from "#{'%02d' % opening_hour.from.hour}:#{'%02d' % opening_hour.from.min}"
json.to "#{'%02d' % opening_hour.to.hour}:#{'%02d' % opening_hour.to.min}" unless opening_hour.to.nil?
