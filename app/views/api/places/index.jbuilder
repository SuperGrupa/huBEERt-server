json.array!(@places) do |place|
    json.partial! 'places/place', place: place
end
