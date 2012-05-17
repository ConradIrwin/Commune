module DomNomery

  def viewDidLoad
    $stderr.puts(dom_def.inspect)
    dom_def.each do |name, klass|
      $stderr.puts([name, klass].inspect)
      if klass == self.class
        Teacup.style(name, view)
      else
        elements[name] = Teacup.create(name)
        elements[name].className = name
        raise "Type mismatch: expected #{klass} got #{elements[name]} for #{name}" unless elements[name].class.ancestors.include?(klass)
        view.addSubview(elements[name])
      end
    end

    domDidNom
  end

  def elements
    @elements ||= {}
  end

  def method_missing(name, *args)
    if args == [] && dom_def[name]
      elements[name]
    else
      super
    end
  end

  def dom_def
    self.class.const_get(:DOM)
  end
end
