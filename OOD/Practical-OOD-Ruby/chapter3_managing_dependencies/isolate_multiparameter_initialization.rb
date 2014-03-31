#Problem definition:
#When Gear is part of an external interface and I have no control over the fixed order of argument list
#that Gear expects and I also create multiple instances of Gear in my application
# what should I do about these kinds of dependencies?

module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    # I have no control over the arguments order of this initialize method because its part of an external interface my application depends. 
    def initialize(chainring, cog, wheel)
      @chainring  = chainring
      @cog        = cog
      @wheel      = wheel
    end
    
    #...
  end
end

#Solution

module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

#1.The GearWrapper is a module. GearWrapper is responsible for creating new instances of Gear. We are using a module here because it allows us define a separate
#  and distinct object to which we can send the gear message and also we are also conveying the message that we are not interested in creating instances of Gearwrapper. 
#2. Gearwrapper's only work is to create instances of Gear. This kind of objects are called factories. Factories are objects whose sole purpose is to create other objects

  
