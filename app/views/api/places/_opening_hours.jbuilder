json.opening_hours place.opening_hours do |oh|
    json.days oh.week_days, :name
    json.from "#{'%02d' % oh.from.hour}:#{'%02d' % oh.from.min}"
    json.to "#{'%02d' % oh.to.hour}:#{'%02d' % oh.to.min}" unless oh.to.nil?
end
