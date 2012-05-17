class CommuneViewController < UIViewController
  include DomNomery

  DOM = {
    commune_view: self,
    how_much: UILabel,
    what_for: UILabel,
    who_paid: UILabel,
    who_participated: UILabel,
    amount: UITextField,
    event: UITextField,
    commune_it: UIButton,
    paid: PersonList::SelectOne,
    participated: PersonList::SelectMany
  }

  def domDidNom
    amount.delegate = self
    event.delegate = self
    commune_it.addTarget(self, action: :click, forControlEvents:UIControlEventTouchUpInside)

    paid.people = Person::ALL
    participated.people = Person::ALL
  end

  def createImages
    @paid = PersonList::SelectOne.new(view, Person::ALL, 300, 300)
    @participated = PersonList::SelectMany.new(view, Person::ALL, 300, 500)
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
    Teacup.update(view)
  end

  def alert(msg)
    alert = UIAlertView.new
    alert.title = "Commune!"
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end
end
