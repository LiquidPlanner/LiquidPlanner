module LiquidPlanner
  module Resources
    class Member < LiquidPlanner::LiquidPlannerResource
      self.prefix = "/api/workspaces/:workspace_id/"
      def avatar
        get_raw(:avatar)
      end
    end
  end
end
