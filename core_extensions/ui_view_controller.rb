class UIViewController

  class << self
    attr_accessor :style_sheet
    attr_accessor :style_name
    attr_accessor :layout_definition

    def layout(name, properties={})
      self.style_name = name
      self.style_sheet = Teacup::StyleSheet.new(self.name) do
        style(name, properties)
      end
      self.layout_definition = {name => {}}
      @current_layout = layout_definition[name]
      yield if block_given?
      $stderr.puts self.layout_definition.inspect
    ensure
      @current_layout = nil
    end

    def subview(name, properties={})
      @previous_layout = @current_layout
      @current_layout = @previous_layout[name] = {}
      self.style_sheet.style(name, properties)
      yield if block_given?
    ensure
      @current_layout = @previous_layout
    end
  end

  attr_accessor :layout

  def method_missing(name, *args, &block)
    layout && layout.elements[name.to_sym] || super
  end

  def viewDidLoad
    self.layout = Teacup::Layout.new(view, style_sheet, self.class.layout_definition)

    layoutDidLoad
    true
  end

  def layoutDidLoad; end
end