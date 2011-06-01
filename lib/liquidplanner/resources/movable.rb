module LiquidPlanner
  # For resources that can be moved
  module Movable
    include MoveOrPackage
    def move_before(item, is_packaged_other=false)
      move_or_package :move, :before, item, is_packaged_other
    end
  
    def move_after(item, is_packaged_other=false)
      move_or_package :move, :after, item, is_packaged_other
    end
  end
end
