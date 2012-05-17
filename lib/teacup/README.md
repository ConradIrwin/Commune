
So... What's the API?


Stylesheets hold your styles, and they are queryable; so given a UIView, you should be able to get the styles out.

However, we might want to use the Stylesheets to also hold animation properties; so maybe the identifier with which you query should *not* be the view itself, but rather it's nom.

Right, so the configuration aspect is actually totally independent of the view stuff; *like*.


So...

```ruby
IPadVertical = Stylesheet.new do

  include IPadBase

  style :foo, like: :bar,

end
```

Stylesheets are "just" modules.


IPadVertical.query(*mooo*)
