module TagsHelper
    def tagging(place_id, options = {})
        weight = options[:weight] || 1
        place = Place.find(place_id)
    
        unless options[:previous].nil?
            options[:previous].split(" ").each do |previous|
                tag_previous = Tag.all.find { |tag| tag.name == previous }
                unless tag_previous.nil?
                    tag_previous.place_ids.delete(place.id)
                    if tag_previous.place_ids.empty?
                        tag_previous.delete
                    else
                        tag_previous.save
                    end
                    place.tags.delete(tag_previous)
                end
            end
        end
        
        options[:current].split(" ").each do |current|
            tag_current = Tag.all.find { |tag| tag.name == current } || Tag.new
            if tag_current.id.nil?
                tag_current.name = current
                tag_current.weight = weight
                tag_current.searched = 0
            end
            tag_current.save
            place.tags << tag_current
        end
    end
end
