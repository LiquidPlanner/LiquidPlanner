module LiquidPlanner

  # sets up the URL and credentials for an API "session",
  # then provides convenience accessors for the account and workspaces
  #
  # N.B. since ActiveResource uses class variables to configure endpoint and
  # auth, you can only have one such "session" active at a time
  #
  class Base
   
    def initialize(options={})
      options.assert_valid_keys(:email, :password, :api_base_url)
      options.assert_required_keys(:email, :password)
      @email        = options[:email]
      @password     = options[:password]
      @api_base_url = options[:api_base_url] || LiquidPlanner::API_BASE_URL
      configure_base_resource
    end

    def account
      LiquidPlanner::Resources::Account.find(:one, :from => "/api/account")
    end

    def workspaces( scope=:all )
      LiquidPlanner::Resources::Workspace.find(scope)
    end

    private

    def configure_base_resource
      LiquidPlannerResource.site     = @api_base_url
      LiquidPlannerResource.user     = @email
      LiquidPlannerResource.password = @password
      LiquidPlannerResource.connection.enable_gzip
    end
                
  end
end
