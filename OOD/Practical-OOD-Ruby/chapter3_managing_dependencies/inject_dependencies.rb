#Problem: Referring to another class by its name creates a major coupling

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

#gear_inches method knows the name of the class Wheel. If the class name changes in future, its going to impact Gear class. When Gear class changes, Gear must also change. But this is not a big deal.
# the hidden problem in this approach is the fact that when gear_inches hard codes a reference to Wheel, it is explicitly telling us that it can only work with Wheel objects and nothing else. It refuses towork with any other object even if the object responds to a diameter method and it uses gears. 

# the code below has an strong bonding to static type. In our case Wheel object is a static type. 
#Wisdom: its not the class of the object thats important, but its the message that we pass to the object.
  def gear_inches
   ratio * Wheel.new(rim, tire).diameter
  end
  
  def ratio
    chainring / cog.to_f
  end
#...
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim      = rim
    @tire     = tire
  end

  def diameter
    rim + (tire * 2)
  end
end

Gear.new(52,11,26,1.5).gear_inches

#Solution

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  
  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

Gear.new(52,11,Wheel.new(26,1.5)).gear_inches


#Notes:
# This technique is called dependency injection. Previously Gear had explicit dependencies on the Wheel class and also on the type and the order of the arguments. Now the dependency has been reduced to a single dependency on the diameter method. 


#open question
# using dependency injection to shape the code relies on my ability to recognise that the responsibility for knowing the name of the class and the responsibility for knowing the method of the class may belong to different objects. the open question is where does the responsibility to know the name of the class lie.



