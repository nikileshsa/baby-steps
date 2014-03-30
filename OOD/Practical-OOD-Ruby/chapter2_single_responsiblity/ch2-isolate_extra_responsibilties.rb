#Problem
# The Gear class has gear_inches method. we are not sure if this is a responsibility of the Gear class? Inside gear_inches class we are calculating the diameter of a wheel.  

class Gear
#...some code...
  def gear_inches
    ratio * (rim + (tires * 2))
  end
end
 
#Refactoring 1 - Extract the diameter calculation into a new
#this refactoring helps us understand the responsibility of Gear class in more detail. Gear class is responsible for calculating the gear inches. But its not responsible for calculating the wheels diameter. 
class Gear
 def gear_inches
   ratio * diameter
 end

#this refactoring just isolates the behavior of diameter calculation. we are doing this even if we have no idea about the ultimate design. But we just know that its a good practice to do this refactoring. Good practices reveal design.

 def diameter
   rim + (tire * 2)
 end
end

#advantages of methods having a single responsibility
#1.Expose previously hidden qualities
#2.Avoid the need for comments
#3.Encourage reuse
#4.Are easy to move to another class


#Refactoring 2 - Does this application need a wheel class?
# My design choice - I am not interested in creating a separate wheel class at this moment. 
# Reasoning behind this design choice
#  a) I have a design restriction on me that I shouldn be creating a new wheel class
#  b) I do not want to create a new wheel class that others might depend on
#  c) I do not want to make an either/or decision on creation of a new wheel class. An eiher/or decision is shortsighted.
#  d) My goal is to preserve single responsibility in Gear while making the fewest design commitments possible.
#  e) Since I am writing changeable code I will wait until I am forced to make this decision of a separate wheel class
#  f) let me not decide now;Let me preserve my ability to make a decision later.

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    chainring / cog.to_f
  end
  
  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire *2)
    end
  end
end
 
#Notes: Embedding Wheel inside Gear is not a long term design goal

