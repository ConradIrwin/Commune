Teacup::StyleSheet.new(:IPad) do
  style :left_label,
    class: UILabel,
    left: 100,
    width: 200,
    height: 50

  style :how_much, like: :left_label,
    top: 100,
    text: 'How Much?'

  style :what_for, like: :left_label,
    top: 175,
    text: 'What for?'

  style :who_paid, like: :left_label,
    top: 300,
    text: 'Who Paid?'

  style :who_participated, like: :left_label,
    top: 480,
    text: 'Who Participated?'

  style :text_box,
    class: UITextField,
    left: 300,
    width: 200,
    height: 50

  style :amount, like: :text_box,
    top: 115,
    placeholder: "$ 0.00",
    keyboardType: UIKeyboardTypeNumberPad

  style :event, like: :text_box,
    top: 190,
    placeholder: "Parada 22"

  style :commune_it,
    class: lambda{ UIButton.buttonWithType(UIButtonTypeRoundedRect) },
    type: UIButtonTypeRoundedRect,
    left: 300, top: 600, width: 400, height: 100,
    title: "Commune it!"

  style :commune_view,
    backgroundColor: UIColor.whiteColor

  style :paid,
    class: PersonList::SelectOne,
    left: 300, top: 290, width: 500, height: 100

  style :participated,
    class: PersonList::SelectMany,
    left: 300, top: 460, width: 500, height: 100
end
