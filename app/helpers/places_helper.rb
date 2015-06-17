module PlacesHelper
    def rate(tableOfWord)
        rate = 0
        self.tags.each do |tag|
            tableOfWord.each do |word|
                if tag.name.upcase == word.upcase
                    rate += tag.weight
                end
            end
        end
        return rate
    end
end
