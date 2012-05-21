class UIViewController
  include Teacup::Layout

  class << self
    attr_accessor :layout_definition

    def layout(name, properties={}, &block)
      self.layout_definition = [name, properties, block]
    end
  end

  def viewDidLoad
    if self.class.layout_definition
      name, properties, block = self.class.layout_definition
      layout(view, name, properties, &block)
    end

    layoutDidLoad
  end

  def layoutDidLoad
    true
  end
end
