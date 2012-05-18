class CommuneViewController < UIViewController

  layout :commune_view do
    subview :how_much
    subview :what_for
    subview :who_paid
    subview :who_participated
    subview :amount
    subview :event
    subview :commune_it
    subview :paid
    subview :participated
    subview :shiny_thing do
      subview :shadow_view, {
        top: 100,
        width: 100,
        height: 100,
        left: 550,
        backgroundColor: UIColor.blackColor
      } do
        subview :rounded_view, {
          cornerRadius: 40,
          top: 10,
          left: 10,
          width: 80,
          height: 80,
          backgroundColor: UIColor.blueColor
        }
      end
    end
  end

  #TODO extend the style-sheet API to make this nicer. override `+`?
  def style_sheet
    super_sheet = self.class.style_sheet
    Teacup::StyleSheet.new(:Temp) do
      if UIDevice.currentDevice.orientation == UIDeviceOrientationLandscapeLeft ||
         UIDevice.currentDevice.orientation == UIDeviceOrientationLandscapeRight
        include Teacup::StyleSheet::IPad
      else
        include Teacup::StyleSheet::IPadVertical
      end
      include super_sheet
    end
  end

  def willAnimateRotationToInterfaceOrientation(io, duration: duration)
    layout.style_sheet = style_sheet
  end

  def layoutDidLoad
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

  def alert(msg)
    alert = UIAlertView.new
    alert.title = "Commune!"
    alert.message = msg
    alert.addButtonWithTitle("OK")
    alert.show
  end
end
