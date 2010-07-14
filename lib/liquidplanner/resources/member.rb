module LiquidPlanner
  module Resources
    class Member < LiquidPlanner::LiquidPlannerResource
      self.prefix = "/api/workspaces/:workspace_id/"
    end
  end
end
