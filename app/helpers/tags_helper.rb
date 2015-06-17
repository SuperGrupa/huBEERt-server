module TagsHelper
    def find_and_delete_tag_from_place(place, previous_text)
        tag = Tag.all.find { |tag| tag.name == previous_text }
        unless tag.nil?
            tag.place_ids.delete(place.id)
            if tag.place_ids.empty?
                tag.delete
            else
                tag.save
            end
            place.tags.delete(tag)
        end
    end
    
    def find_and_add_tag_to_place(place, current_text, weight)
        tag = Tag.all.find { |tag| tag.name == current_text } || Tag.new
        if tag.id.nil?
            tag.name = current_text
            tag.weight = weight
            tag.searched = 0
        end
        tag.save
        place.tags << tag
    end

    def tagging(place_id, options = {})
        weight = options[:weight] || 1
        place = Place.find(place_id)
    
        unless options[:previous].nil?
            options[:previous].split(" ").each do |previous|
                find_and_delete_tag_from_place(place, previous)
            end
        end
        
        options[:current].split(" ").each do |current|
            find_and_add_tag_to_place(place, current, weight)
        end
    end
end
