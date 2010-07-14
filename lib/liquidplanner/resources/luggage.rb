module LiquidPlanner
  module Resources
    class Luggage < LiquidPlanner::LiquidPlannerResource
      self.prefix = "/api/workspaces/:workspace_id/:item_collection/:item_id/"
    end
  end
end

