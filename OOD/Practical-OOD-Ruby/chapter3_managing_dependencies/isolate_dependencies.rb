#Problem: What to do if you cant completly remove dependencies in an existing application even though it is technically possible but not actually possible.

#Solution 1

class Gear
  attr_reader :chainring, :cog, :rim, :tire 

# here we are isolating the Wheel object creation to the initialize method. its just like quarantining the Object creation to a method. But we should note that this creates a new Wheel class unconditionally everytime we create a Gear class

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @tire      = title
    @rim       = rim
    wheel      = Wheel.new(rim, tire)
  end
# this type of design clears up the gear_inches method. 
  def gear_inches
    ratio * wheel.diameter
  end
 
  def ratio
    chainring / cog.to_f
  end
end

#Solution 2

class Gear
  #assumption: we cant enforce a injection dependency because its a existing application
  # in this initialize method too, Gear knows too much about Wheel class's rim and tire
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @tire      = title
    @rim       = rim
  end
# this type of design clears up the gear_inches method. 
  def gear_inches
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end
  
# here we are isolating the Wheel object creation to the wheel method. its just like quarantining the Object creation to a method. the ||= does a lazy initialisation of the Wheel object. it means the creation of Wheel object is postponed until someone invokes the gear_inches method.

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end



