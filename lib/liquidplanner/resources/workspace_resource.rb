module LiquidPlanner
  module Resources
    class WorkspaceResource < LiquidPlanner::LiquidPlannerResource
      self.prefix = "/api/workspaces/:workspace_id/"
    end
  end
end

