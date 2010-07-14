module LiquidPlanner
  module RelativeResource
    def move_relative_to(tree, relative, other)
      raise ArgumentError.new("tree must be prioritize or organize")  unless [:prioritize, :organize].include?(tree)
      raise ArgumentError.new("relative must be before or after")     unless [:before, :after].include?(relative)
      other_id = other.is_a?(LiquidPlanner::LiquidPlannerResource) ? other.id : other
      
      response = post("#{tree}_#{relative}", :other_id=>other_id)
      load( self.class.format.decode( response.body ) )
    end
  end
end