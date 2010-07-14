module LiquidPlanner
  module Resources
    class Account < LiquidPlanner::LiquidPlannerResource

      def self.account
        find( :one, :from => "/api/account" )
      end

    end
  end
end

