class PersonButton < UIButton
  include CocoaHelpers
  attr_accessor :block
  attr_accessor :person

  def person=(person)
    @person = person
    self.backgroundColor = colorImage(person.image)
  end

  def onTouchUp(&block)
    self.addTarget(self, action: :callback, forControlEvents:UIControlEventTouchUpInside)
    self.block = block
  end

  def callback
    block.call(self) if block
  end

  def selected=(selected)
    @selected = selected
    animate_to_stylename(selected ? :person_button_selected : :person_button)
  end

  attr_reader :selected
  def selected?
    !!@selected
  end
end
