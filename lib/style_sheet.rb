class StyleSheet

  class Ruleset
    attr_accessor :className, :properties, :frame, :superRule, :block, :constructor
    def initialize(className, properties, &block)
      self.className = className
      self.properties = properties
      self.superRule = properties.delete(:like)
      self.constructor = properties.delete(:is_a) || (superRule && superRule.constructor) || UIView
      self.frame = properties.delete(:frame) || (superRule && superRule.frame) || [[0,0], [100,50]]
      self.block = block


      left = properties.delete(:left) || frame[0][0]
      top = properties.delete(:top) || frame[0][1]
      width = properties.delete(:width) || frame[1][0]
      height = properties.delete(:height) || frame[1][1]
      self.frame = [[left, top], [width, height]]
    end

    def apply_to(view, stylesheet)
      superRule.apply_to(view, stylesheet) if superRule
      view.frame = frame
      self.properties.each do |name, value|
        if view.respond_to?(:"#{name}=")
          view.send(:"#{name}=", value)
        elsif view.respond_to?(name)
          view.send(name, *value)
        else
          $stderr.puts "WARNING: #{stylesheet.name}@:#{className} got unknown style property: #{name} for #{view}"
        end
      end
      view.instance_eval(&block) if block
    end

    def create(stylesheet)
      instance = Proc === constructor ? constructor.call : constructor.new
      apply_to(instance, stylesheet)
      instance
    end
  end

  def self.nom(*classNames, &block)
    properties = classNames.pop
    if like = properties[:like]
      properties[:like] = rulesets.detect{|x| x.className == like }
      unless properties[:like] 
        $stderr.puts "WARNING: specified #{classNames.join(",")} like #{like} that didn't exist!"
      end
    end
    classNames.each do |cn|
      rulesets << Ruleset.new(cn, properties, &block)
    end
  end

  def self.rulesets
    @rulesets ||= []
  end

  def self.apply(name, view)
    view.tap do
      rulesets.each do |ruleset|
        if ruleset.className == name
          ruleset.apply_to(view, self)
        end
      end
    end
  end

  def self.create(name, superview)
    my_rule = rulesets.detect do |ruleset|
      ruleset.className == name
    end
    
    my_rule.create(self).tap do |subview|
      superview.addSubview(subview)
    end
  end

  def self.current
    # TODO :)
    @current ||= case UIDevice.currentDevice.model
                  when /iPhone/
                    StyleSheet::IPad

                  when /iPad/
                    StyleSheet::IPad

                  else
                    StyleSheet::IPad

                  end
  end
end
