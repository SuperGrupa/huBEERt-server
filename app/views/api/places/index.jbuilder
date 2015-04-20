json.array!(@places) do |place|
    json.partial! 'places/place_condensed', place: place
end
