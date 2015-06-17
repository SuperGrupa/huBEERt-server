module TagsHelper
    def tagging(place_id, options = {})
        if self.changed?
            weight = options[:weight] || 1
            place = Place.find(place_id)
        
            tag_previous = Tag.all.find { |tag| tag.name == options[:previous] }
            unless tag_previous.nil?
                tag_previous.place_ids.delete(place.id)
                if tag_previous.place_ids.empty?
                    tag_previous.delete
                else
                    tag_previous.save
                end
                place.tags.delete(tag_previous)
            end
            
            tag_current = Tag.all.find { |tag| tag.name == options[:current] } || Tag.new
            if tag_current.id.nil?
                tag_current.name = options[:current]
                tag_current.weight = weight
                tag_current.searched = 0
            end
            tag_current.save
            place.tags << tag_current
        end
    end
end
