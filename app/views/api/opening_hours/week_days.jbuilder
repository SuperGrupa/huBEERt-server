json.array!(@week_days) do |week_day|
    json.extract! week_day, :id, :name
end
