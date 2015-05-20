json.array!(@districts) do |district|
    json.extract! district, :id, :name
end
