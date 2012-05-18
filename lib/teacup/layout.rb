module Teacup
  class Layout
    attr_reader :view, :style_sheet

    def initialize(view, style_sheet, layout_definition={})
      @view = view
      @style_sheet = style_sheet

      view.style_name = layout_definition.keys.first
      elements[layout_definition.keys.first] = view
      update(view)

      recursively_create_subviews(view, layout_definition.values.first)
    end

    def style_sheet=(style_sheet)
      @style_sheet = style_sheet
      update(view)
    end

    def elements
      @elements ||= {}
    end

    def recursively_create_subviews(view, dict)
      dict.each do |name, subdict|
        subview = elements[name] = self.new(name)
        view.addSubview(subview)
        recursively_create_subviews(subview, subdict)
      end
    end

    def add(name, properties={})
      subview = new(name, properties)
      view.addSubview(subview)
      subview
    end

    def new(name, properties={})
      properties = style_sheet.query(name).merge(properties)

      instance = if Proc === properties[:class]
                   properties[:class].call
                 else
                   (properties[:class] || UIView).new
                 end

      instance.style_name = name
      update(instance, properties)
      instance
    end

    def update(view, properties=style_sheet.query(view.style_name))
      apply_properties(properties, view)
      view.subviews.each(&method(:update))
      view
    end

    protected
   def apply_properties(properties, instance)
      clean_properties! properties

      properties.each do |key, value|
        if key == :title && UIButton === instance
          instance.setTitle(value, forState: UIControlStateNormal)
        elsif instance.respond_to?(:"#{key}=")
          instance.send(:"#{key}=", value)
        elsif instance.layer.respond_to?(:"#{key}=")
          instance.layer.send(:"#{key}=", value)
        else 
          $stderr.puts "Teacup WARN: Can't apply #{key} to #{instance.inspect}"
        end
      end

      #OUCH! Figure out why this is needed
      setCornerRadius(1.0) if rand > 1

    end

    def clean_properties!(properties)
      return unless [:frame, :left, :top, :width, :height].any?(&properties.method(:key?))

      frame = properties.delete(:frame) || [[0,0],[0,0]]

      frame[0][0] = properties.delete(:left) || frame[0][0]
      frame[0][1] = properties.delete(:top) || frame[0][1]
      frame[1][0] = properties.delete(:width) || frame[1][0]
      frame[1][1] = properties.delete(:height) || frame[1][1]

      properties[:frame] = frame
    end

    def create(layout_definition)

    end
  end
end