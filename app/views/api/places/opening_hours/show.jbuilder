json.array!(@opening_hours) do |op|
    json.partial! 'places/opening_hours/basic', opening_hour: op
end
