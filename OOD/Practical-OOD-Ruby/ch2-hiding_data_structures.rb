#If being attached to an instance variable is bad, attaching to a complicated data structure is worse

class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

# the diameters method not only knows how to calculate diameters, but also where to find rims and tires in the array. the diameters method DEPENDS on the array structure. If that structure changes this code must change. if we have data in an array, its not long before we will have references to that array's structure all over.The references are leaky.They escape encapsulation and spread themselves througout the code. They are not DRY.
  def diameters
    data.collect { |cell|
      cell[0] + (cell[1] * 2) }
    end
# many other methods that index into the array
end

@data = [[622,22],[232,23],[333,23]]

# in Ruby its easy to seperate structure from meaning. Just as we use a method to wrap an instance variable, we can use the ruby Struct class to wrap a structure.

class RevealingReferences
  attr_reader  :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

# the diameters method has no knowledge of the internal structure of wheel.
  def diameters
    wheels.collect { |wheel|
      wheel.rim + (wheel.tire * 2) }
  end

  Wheel = Struct.new(:rim, :tire)
#all knowledge of structure of the incoming array has been isolated into the wheelify method which converts an array of arrays into an array of structs. wheelify method creates light weight objects that respond to rim and tires
# this style of code allows us to protect against changes in externally owned data structures and to make our code more readable and intention revealing. it trades indexing into a structure for sending messages to an object.

  def wheelify(data)
    data.collect { |cell|
      Wheel.new(cell[0],cell[1]) }
  end
end

#Problem:
# the diameter method has two responsibilities. 1. iterate over the wheels. 2. calculate the diameter. 
#Solution:
#We must try to enforce single responsibilty to methods like we try to do for classes.
