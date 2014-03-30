#Problem: Examine the code below and list the dependencies between Gear class and Wheel class 

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim       = rim
    @tire      = tire
  end
 
  def diameter
    rim + (tire * 2)
  end
#...
end


Gear.new(52,11,26,1.5).gear_inches


#Identified dependencies:
#1.Name of the class. Gear expects a class named Wheel to exist
#2.Name of the message that it intends to send to someone other than the self. Gear expects a Wheel instance to respond to diameter
#3.The argument the message a requires. Gear knows that Wheel.new requires a rim and a tire
#4.The order of the arguments. Gear knows that the first argument to Wheel.new must be rim and the second argument must be tire

#Notes
# These dependencies create coupling between these two classes. 

   
