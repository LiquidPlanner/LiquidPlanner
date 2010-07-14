module LiquidPlanner
  # For resources that can be prioritized
  module Priority
    include RelativeResource
    def prioritize_before(item)
      move_relative_to :prioritize, :before, item
    end
  
    def prioritize_after(item)
      move_relative_to :prioritize, :after, item
    end
  end
end