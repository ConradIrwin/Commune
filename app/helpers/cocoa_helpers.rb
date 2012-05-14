module CocoaHelpers
  def colorImage(file)
    UIColor.colorWithPatternImage(UIImage.imageNamed(file))
  end
end
