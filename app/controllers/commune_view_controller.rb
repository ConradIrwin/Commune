class CommuneViewController < UIViewController

  attr_accessor :amount, :event, :commune_it, :paid, :participated

  $stderr.puts 1
  layout(:commune_view) do |view|
    $stderr.puts 2
    subview(UILabel, :how_much)
    subview(UILabel, :what_for)
    subview(UILabel, :who_paid)
    subview(UILabel, :who_participated)

    self.amount = subview(UITextField, :amount,
      delegate: self)
    self.event = subview(UITextField, :event,
      delegate: self)

    self.commune_it = subview(UIButton.buttonWithType(UIButtonTypeCustom), :commune_it)
    commune_it.addTarget(self, action: :click, forControlEvents:UIControlEventTouchUpInside)

    self.paid = subview(PersonList::SelectOne, :paid,
      people: Person::ALL)
    self.participated = subview(PersonList::SelectMany, :participated,
      people: Person::ALL)

    subview(UIView,
              top: 100,
              width: 100,
              height: 100,
              left: 550,
              backgroundColor: UIColor.blackColor
            ) do |shiny_thing|
              subview(UIView,
                cornerRadius: 30,
                top: 10,
                left: 10,
                width: 80,
                height: 80,
                backgroundColor: UIColor.blueColor
              )
            end
  end

  stylesheet :ipad

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

  def alert(msg)
    alert = UIAlertView.new
    alert.title = "Commune!"
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end
end
