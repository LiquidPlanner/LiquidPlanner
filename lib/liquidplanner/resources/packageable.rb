module LiquidPlanner
  # For resources that can be packaged
  module Packageable
    include MoveOrPackage
    def package_before(item)
      move_or_package :package, :before, item
    end
  
    def package_after(item)
      move_or_package :package, :after, item
    end
  end
end
