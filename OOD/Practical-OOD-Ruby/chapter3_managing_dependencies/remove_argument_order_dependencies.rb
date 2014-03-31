#Problem Definition: Many method signatures require arguments be passed in a fixed order. When i send a message, i as a sender cannot avoid having knowledge of the arguments. this dependency is unavoidable.

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end
  
  def gear_inches
  end
  #...
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim      = rim
    @tire     = tire   
  end
end

# here I need to know order of the arguments to be passed to the initialize method of Gear. 
Gear.new(52, 11, Wheel.new(26,1.5)).gear_inches


#Solution 1

class Gear
  attr_reader :chainring, :cog, :wheel
# this technique removes dependency on argument order

  def initialize(args)
    @chainring = args[:chainring] || 40  # use the || with caution since its just a or condition. if the left hand has an expression which always defaults to true, we are in trouble. this method of setting the default will work only when the [] method of hash returns nil when the value for a key is missing. 
    @cog       = args[:cog]       || 34
    @wheel     = args[:wheel]
  end
 
  def gear_inches
  end
  #...
end

#adds more verbosity to the arguments. It provides documentation about the arguments.
Gear.new(:chainring => 52,
         :cog       => 11,
         :wheel     => Wheel.new(26,1.5)).gear_inches


#notes:
# Sometimes its good to take the middle path and have a fixed number of arguments followed by a variable list of arguments

#Solution 2
# the use of fetch for initializing the defaults
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
      @chainring = args.fetch(:chainring, 40)  #the fetch method here helps in handling the defaults in a better way than the || operator. The fetch method expects the key we are fetching to be in the hash and if we dont find the key, this method gives more options to manage the process of setting the default. its advantage is that it doesn't automatically return nil when it fails to find a key.
      @cog       = args.fetch(:cog,12)
      @wheel     = args[:wheel]
  end
end


#Solution 3
# the use of merge and default method in initialization
class Gear
   attr_reader :chainring, :cog, :wheel
   # we can completely remove defaults from the initialze method and isolate them inside a separate wrapping method. Why and when this is useful? The isolation technique is useful when the defaults are more complicated. 
   def initialize(args)
     args = defaults.merge(args)
     @chainring = args[:chainring]
     @cog       = args[:cog]
     @wheel     = args[:wheel]
   end
   # The defaults method defines a second hash which merges into the options hash during the initialization of the object.
   def defaults 
     {:chainring => 40, :cog => 12}
   end
end





