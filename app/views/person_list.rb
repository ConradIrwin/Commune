class PersonList < UIView
  include CocoaHelpers
  attr_reader :people

  def people=(people)
    @people = people
    drawImages
  end

  def touched(button)
    findAndResignFirstResponder
  end

  def buttons
    @buttons ||= []
  end

  def drawImages
    people.each_with_index do |person, i|
      layout(PersonButton, :person_button,
        person: person,
        frame: [[i * 110, 0], [80, 80]]
      ) do |button|
        button.onTouchUp(&method(:touched))
        buttons << button
      end
    end
    setNeedsLayout
  end

  class SelectOne < PersonList
    def touched(button)
      super
      selected_button.selected = false if selected_button && selected_button != button
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
      super
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
