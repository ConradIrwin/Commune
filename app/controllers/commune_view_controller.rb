class CommuneViewController < UIViewController

  attr_accessor :amount, :event, :commune_it, :paid, :participated

  interface(:commune_view) do |view|
    layout(UILabel, :how_much)
    layout(UILabel, :what_for)
    layout(UILabel, :who_paid)
    layout(UILabel, :who_participated)

    self.amount = layout(UITextField, :amount,
      delegate: self)
    self.event = layout(UITextField, :event,
      delegate: self)

    self.commune_it = layout(UIButton.buttonWithType(UIButtonTypeCustom), :commune_it)
    commune_it.addTarget(self, action: :click, forControlEvents:UIControlEventTouchUpInside)

    self.paid = layout(PersonList::SelectOne, :paid,
      people: Person::ALL)
    self.participated = layout(PersonList::SelectMany, :participated,
      people: Person::ALL)

    layout(UIView,
              top: 100,
              width: 100,
              height: 100,
              left: 550,
              backgroundColor: UIColor.blackColor
            ) do |shiny_thing|
              layout(UIView,
                cornerRadius: 30,
                top: 10,
                left: 10,
                width: 80,
                height: 80,
                backgroundColor: UIColor.blueColor
              )
            end
  end

  def stylesheet
    if [UIDeviceOrientationLandscapeLeft,
        UIDeviceOrientationLandscapeRight].include?(UIDevice.currentDevice.orientation)
      Teacup::Stylesheet::IPad
    else
      Teacup::Stylesheet::IPadVertical
    end
  end

  def textFieldShouldReturn(textField)
    if textField == amount
      event.becomeFirstResponder
    else
      event.resignFirstResponder
    end
  end

  def click
    form = Form.new(amount.text, @paid.selection, @participated.selection, event.text)
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
    true
  end

  def willAnimateRotationToInterfaceOrientation(io, duration: duration)
    restyle!
  end

  def alert(msg)
    alert = UIAlertView.new
    alert.title = "Commune!"
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end
end
