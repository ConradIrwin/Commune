class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def image
    "#{@name.downcase}.jpg"
  end

  ALL = [
    new('Conrad'),
    new('Lee'),
    new('Martin'),
    new('Rahul'),
    new('Sam')
  ]
end
