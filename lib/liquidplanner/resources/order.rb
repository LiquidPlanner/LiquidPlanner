module LiquidPlanner
  # For resources that can be prioritized
  module Order
    include RelativeResource
    def organize_before(item)
      move_relative_to :organize, :before, item
    end
  
    def organize_after(item)
      move_relative_to :organize, :after, item
    end
  end
end