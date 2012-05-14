class ImageList
  include CocoaHelpers
  attr_accessor :view, :images, :left, :top

  def initialize(view, images, left, top)
    self.view = view
    self.images = images
    self.left = left
    self.top = top

    drawImages
  end

  def touched(button)
    raise NotImplementedError
  end

  def drawImages
    images.each_with_index do |name, i|
    button = ImageButton
      view.addSubview(ImageButton.new.tap{ |button|
        button.image = name
        button.frame = [[self.left + i * 100, self.top - 20], [80, 80]]
        button.onTouchUp(&method(:touched))
      })
    end
  end

  class SelectOne < ImageList
    attr_accessor :selection

    def touched(button)
      selection.selected = false if selection
      self.selection = button
      selection.selected = true
    end
  end

  class SelectMany < ImageList
    def selection
      @selection ||= []
    end

    def touched(button)
      if selection.include?(button)
        selection.delete button
        button.selected = false
      else
        selection << button
        button.selected = true
      end
    end
  end
end
