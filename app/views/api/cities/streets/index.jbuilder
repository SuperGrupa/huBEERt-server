json.array!(@streets) do |street|
    json.extract! street, :id, :name
end

