class StyleSheet
  class IPad < StyleSheet
    nom :left_label,
      is_a: UILabel,
      left: 100,
      width: 200,
      height: 50

    nom :how_much, like: :left_label,
      top: 100,
      text: 'How Much?'

    nom :what_for, like: :left_label,
      top: 175,
      text: 'What for?'

    nom :who_paid, like: :left_label,
      top: 300,
      text: 'Who Paid?'

    nom :who_participated, like: :left_label,
      top: 480,
      text: 'Who Participated?'

    nom :text_box,
      is_a: UITextField,
      left: 300,
      width: 200,
      height: 50

    nom :amount, like: :text_box,
      top: 115,
      placeholder: "$ 0.00",
      keyboardType: UIKeyboardTypeNumberPad

    nom :event, like: :text_box,
      top: 190,
      placeholder: "Parada 22"

    nom :commune_it,
      is_a: lambda{ UIButton.buttonWithType(UIButtonTypeRoundedRect) },
      type: UIButtonTypeRoundedRect,
      frame: [[300, 600], [400, 100]] do
        setTitle("Commune it!", forState: UIControlStateNormal) 
      end

    nom :commune_view,
      backgroundColor: UIColor.whiteColor

    nom :paid,
      is_a: PersonList::SelectOne,
      frame: [[300, 290], [500, 100]]

    nom :participated,
      is_a: PersonList::SelectMany,
      frame: [[300, 460], [500, 100]]
  end
end

