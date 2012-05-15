class CommuneViewController < UIViewController

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
    @paid = PersonList::SelectOne.new(view, Person::ALL, 300, 300)
    @participated = PersonList::SelectMany.new(view, Person::ALL, 300, 500)
  end

  def createTextbox
    view.addSubview(@amount = UITextField.new.tap{ |amount|
      amount.delegate = self
      amount.frame = [[300, 115], [200, 50]]
      amount.placeholder = "$ 0.00"
      amount.keyboardType = UIKeyboardTypeNumberPad
    })
    view.addSubview(@event = UITextField.new.tap{ |event|
      event.delegate = self
      event.frame = [[300, 190], [200, 50]]
      event.placeholder = "Parada 22"
    })
  end

  def textFieldShouldReturn(textField)
    if textField == @amount
      @event.becomeFirstResponder
    else
      @event.resignFirstResponder
    end
  end

  def addButton
  NSUTF8StringEncoding
    view.addSubview(UIButton.buttonWithType(UIButtonTypeRoundedRect).tap{ |button|
      button.setTitle('Commune!', forState:UIControlStateNormal)
      button.frame = [[300,600], [400, 100]]
      button.addTarget(self, action: :click, forControlEvents:UIControlEventTouchUpInside)
    })
  end

  def description
    "#{@paid.selection && @paid.selection.name || 'no-one'} paid #{@amount.text} at #{@event.text} for #{@participated.selection.map(&:name).join(", ")}"
  end

  def click
    form = Form.new(@amount.text, @paid.selection, @participated.selection, @event.text)
    return alert(form.validation_errors.join(", ")) unless form.valid?

    response = form.submit!

    if response =~ /Your response has been recorded./
      alert('w00t!, response recorded!');
    else
      $stderr.puts response
      alert('ZOMG, it didn"t work :(');
    end
  end

  def shouldAutorotateToInterfaceOrientation(io)
    [UIDeviceOrientationLandscapeLeft, UIDeviceOrientationLandscapeRight].include?(io)
  end

  def alert(msg)
    alert = UIAlertView.new
    alert.title = "Commune!"
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end
end
