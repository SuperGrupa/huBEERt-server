json.array!(@ratings) do |rating|
    json.partial! 'places/place_condensed', place: rating[:place]
    json.rating rating[:searchRating]
end

