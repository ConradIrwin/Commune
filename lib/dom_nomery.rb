module DomNomery
  def viewDidLoad
    dom_def.each do |name, klass|
      if klass == self.class
        StyleSheet.current.apply(name, view)
      else
        elements[name] = StyleSheet.current.create(name, view)
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
