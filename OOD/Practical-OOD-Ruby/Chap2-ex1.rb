#An example Gear Class

class Gear
 attr_reader :chainring, :cog
 def initialize(chainring, cog)
   @chainring = chainring
   @cog       = cog
 end

 def ratio
   chaining / cog.to_f
 end
end
