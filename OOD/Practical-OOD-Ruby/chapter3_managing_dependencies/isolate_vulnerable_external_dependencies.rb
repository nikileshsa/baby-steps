#Problem: When a class has embedded reference to a message that is likely to change, what approach should we take while designing the class        

#Problem Description  

class Gear
  attr_reader :chainring, :cog, :rim, :tire 
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @tire      = title
    @rim       = rim
    wheel      = Wheel.new(rim, tire)
  end
#  the gear_inches class is more complex here. gear_inches has an external dependency here. a method is said to have an external dependency when it passes a message to an object other than the self. The gear_inches knows that wheel object has a diameter. This dependency is dangerous since it couples gear_inches to an external object and one of its methods; in our case  the diameter method.  
  def gear_inches
    #... some complex code
   foo = some_intermediate_result * ratio * wheel.diameter
    # ...some complex code
  end
 
  def ratio
    chainring / cog.to_f
  end
end

#Solution 1

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
# this type of design clears up the gear_inches method. here gear_inches is more abstract. When I move the wheel.diameter to a separate method, I enforce gear_inches to depend on a message sent to self.It no more relies on message passing to an external object's method
  
  def gear_inches
    #... some complex code
    ratio * diameter
    #... some complex code
  end

  def ratio
    chainring / cog.to_f
  end
  
# here we are isolating the Wheel object creation to the wheel method. its just like quarantining the Object creation to a method. the ||= does a lazy initialisation of the Wheel object. it means the creation of Wheel object is postponed until someone invokes the gear_inches method.

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end

# I would have written this method anyways if I have had so many references to wheel.diameter in my code. In this case, i am creating this method preemptively to remove the dependency from gear_inches method
  def diameter
    wheel.diameter
  end
end

#Notes:
# An alternative way to eliminate this problem from the very beginning is to reverse the direction of dependency.

