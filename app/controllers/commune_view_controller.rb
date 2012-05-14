class CommuneViewController < UIViewController

  IMAGES = ["conrad.jpg", "lee.jpg", "martin.jpg", "rahul.jpg", "sam.jpg"]

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    createLabels
    createImages
    createTextbox
    addButton
  end

  def createLabels
    addLabel('How Much?', 100);
    addLabel('What for?', 175);
    addLabel('Who Paid?', 300);
    addLabel('Who Participated?', 500);
  end

  def addLabel(text, offset)
    view.addSubview(UILabel.new.tap{ |label|
      label.text = text
      label.frame = [[100, offset], [200, 50]]
    })
  end

  def createImages
    @paid = ImageList::SelectOne.new(view, IMAGES, 300, 300)
    @participated = ImageList::SelectMany.new(view, IMAGES, 300, 500)
  end

  def createTextbox
   view.addSubview(@amount = UITextField.new.tap{ |amount|
      amount.frame = [[300, 115], [100, 50]]
      amount.placeholder = "$ 0.00"
    })
    view.addSubview(@event = UITextField.new.tap{ |amount|
      amount.frame = [[300, 190], [100, 50]]
      amount.placeholder = "Parada 22"
    })
  end

  def addButton
    view.addSubview(UIButton.buttonWithType(UIButtonTypeRoundedRect).tap{ |button|
      button.setTitle('Commune!', forState:UIControlStateNormal)
      button.frame = [[300,600], [400, 100]]
      button.addTarget(self, action: :click, forControlEvents:UIControlEventTouchUpInside)
    })
  end

  def description
    "Paid #{@amount.text} for #{@event.text}"
  end

  def click
    UIAlertView.new.tap{ |alert|
      alert.title = "MOOO"
      alert.message = description
      alert.addButtonWithTitle("oo")
      alert.show
    }
  end

  def shouldAutorotateToInterfaceOrientation(io)
    [UIDeviceOrientationLandscapeLeft, UIDeviceOrientationLandscapeRight].include?(io)
  end
end
