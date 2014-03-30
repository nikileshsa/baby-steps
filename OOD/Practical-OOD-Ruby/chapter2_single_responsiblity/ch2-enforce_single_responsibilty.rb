 
#Problem:
#The diameter method has two responsibilities. 1. iterate over the wheels. 2. calculate the diameter. 
#Solution:
#We must try to enforce single responsibilty to methods like we try to do for classes.


#before enforcing single responsibility

class RevealingReferences
  attr_reader :wheel
  def initialize(data)
    @wheels = wheelfily(data)
  end

  def diameters
    wheels.collect{ |wheel|
     wheel.rim + (wheel.tire *2) }
  end

  Wheel = Struct.new(:tire, :rim)
  def wheelify(data)
    data.collect{|cell|
      Wheel.new(cell[0],cell[0]) }
  end
end

#After enforcing single responsibility at the message level
class RevealingReferences
  attr_reader :wheel
  def initialize(data)
    @wheels = wheelify(data)
  end

#diameters method has a single responsibility. 
  def diameters
    wheels.collect{ |wheel| diameter(wheel)}
  end
  
  def diameter(wheel)
   wheel.rim + (wheel.tire * 2)
  end
  
 Wheel = Struct.new(:tire, :rim)
 def wheelify(data)
   data.collect {|cell|
     Wheel.new(cell[0],cell[1])}
 end
end

#Notes:
# the design goal in this example is to write code that is easily changeable.
# This  refactoring introduces an additional message send but at this point in our design we should act as if sending a message is free
# Here we are separating iteration from action and the diameter method is a good side effect and other methods can use it

