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
    if selected
      self.transform = CGAffineTransformMakeRotation(Math::PI / 4)
    else
      self.transform = CGAffineTransformMakeRotation(0)
    end
    @selected = selected
  end

  attr_reader :selected
  def selected?
    !!@selected
  end
end
