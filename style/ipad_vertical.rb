Teacup::Stylesheet.new(:IPadVertical) do
  import :IPad

  def below(stylename, offset)
    prev = query(stylename)
    prev[:top] + prev[:height] + offset
  end

  style :text_box, :paid, :participated, :left_label,
    left: 120

  style :how_much,
    top: 120

  style :amount,
    top: below(:how_much, 20)

  style :what_for,
    top: below(:amount, 40)

  style :event,
    top: below(:what_for, 20)

  style :who_paid,
    top: below(:event, 40)

  style :paid,
    top: below(:who_paid, 20)

  style :who_participated,
    top: below(:paid, 50)

  style :participated,
    top: below(:who_participated, 20)

  style :commune_it,
    top: below(:participated, 50),
    left: 200,
    width: 350

end
