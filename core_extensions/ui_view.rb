class UIView
  # http://stackoverflow.com/questions/1823317/how-do-i-legally-get-the-current-first-responder-on-the-screen-on-an-iphone
  def findAndResignFirstResponder
     if isFirstResponder
       resignFirstResponder
     else
       subviews.each(&:findAndResignFirstResponder)
     end
  end
end
