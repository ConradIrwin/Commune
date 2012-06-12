Teacup::Stylesheet.new :ipad do

  style :left_label,
    color: UIColor.whiteColor,
    backgroundColor: UIColor.blackColor,
    left: 100,
    width: 200,
    height: 50,
    portrait: {left: 120}

  style :text_box,
    textColor: UIColor.greenColor.colorWithAlphaComponent(0.7),
    left: 300,
    width: 200,
    height: 50,
    portrait: {left: 120}

  style :how_much, extends: :left_label,
    top: 100,
    text: 'How Much?',
    portrait: {top: (top = 120)}

  style :amount, extends: :text_box,
    top: 115,
    placeholder: "$ 0.00",
    keyboardType: UIKeyboardTypeNumberPad,
    portrait: {top: (top += 90)}

  style :what_for, extends: :left_label,
    top: 175,
    text: 'What for?',
    portrait: {top: (top += 80)}

  style :event, extends: :text_box,
    top: 190,
    placeholder: "Parada 22",
    portrait: {top: (top += 90)}

  style :who_paid, extends: :left_label,
    top: 300,
    text: 'Who Paid?',
    portrait: {top: (top += 80)}

  style :paid,
    left: 300, top: 290, width: 500, height: 100,
    portrait: {top: (top += 80), left: 120}

  style :who_participated, extends: :left_label,
    top: 480,
    text: 'Who Participated?',
    portrait: {top: (top += 100)}

  style :participated,
    left: 300, top: 460, width: 500, height: 100,
    portrait: {top: (top += 80), left: 120}

  style :commune_it,
    left: 300, top: 600, width: 400, height: 100,
    title: "Commune it!",
    backgroundColor: UIColor.blueColor.colorWithAlphaComponent(0.5),
    cornerRadius: 10,
    portrait: {top: (top += 100), left: 250, width: 350}

  style :commune_view,
    backgroundColor: UIColor.blackColor

  style :person_button,
    alpha: 0.3

  style :person_button_selected, extends: :person_button,
    alpha: 0.9
end
