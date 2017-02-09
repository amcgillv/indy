module ApplicationHelper

    def cache_unless_admin *args
      if !current_user.present?
        cache args do
          yield
        end
      else
        yield
      end
    end

    def link_people(people, route)
        return "" if people.blank?
        authors = []
        #fucking Oxford comma is gonna ruin me
        people = people.gsub(", and", " and").gsub(", &", " &")
        # get rid of initial comma list, leave the last thing untouched
        if people.include? ", "
            comma_split = people.split ", "
            authors = authors + comma_split[0..-2]
            people = comma_split[-1]
        end
        # stuff left over should have the names on both side of the ampersand.
        # fucking Oxford comma:
        if people.include? " & "
            amp_split = people.split " & "
            authors = authors + amp_split[0..-2]
            people = amp_split[-1]
        end
        if people.include? " and "
            and_split = people.split " and "
            authors = authors + and_split[0..-2]
            people = and_split[-1]
        end
        # should be left with one author
        authors.push people
        # linkify
        authors = authors.map { |a| '<a href="' + route + '?n=' + a + '">' + a + '</a>' }
        # rails comes thru with the to_sentence
        people = authors.to_sentence({ last_word_connector: " & ", two_words_connector: " & "})
        people = "by " + people
        raw(people)
    end
    
end
