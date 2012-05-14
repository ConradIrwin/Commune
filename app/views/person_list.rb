class PersonList
  include CocoaHelpers
  attr_accessor :view, :people, :left, :top

  def initialize(view, people, left, top)
    self.view = view
    self.people = people
    self.left = left
    self.top = top

    drawImages
  end

  def touched(button)
    raise NotImplementedError
  end

  def buttons
    @buttons ||= []
  end

  def drawImages
    people.each_with_index do |person, i|
      view.addSubview(PersonButton.new.tap{ |button|
        button.person = person
        button.frame = [[self.left + i * 100, self.top - 20], [80, 80]]
        button.onTouchUp(&method(:touched))
        buttons << button
      })
    end
  end

  class SelectOne < PersonList
    def touched(button)
      selected_button.selected = false if selection
      button.selected = true
    end

    def selected_button
      buttons.detect(&:selected?)
    end

    def selection
      selected_button && selected_button.person
    end
  end

  class SelectMany < PersonList
    def touched(button)
      button.selected = !button.selected
    end

    def selected_buttons
      buttons.select(&:selected?)
    end

    def selection
      selected_buttons.map(&:person)
    end
  end
end
