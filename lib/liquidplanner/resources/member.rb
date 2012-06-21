module LiquidPlanner
  module Resources
    class Member < WorkspaceResource 
      def avatar
        get_raw(:avatar)
      end
    end
  end
end
