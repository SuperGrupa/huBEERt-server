json.array!(@ratings) do |rating|
    json.partial! 'places/place_condensed', place: rating[:place]
end

