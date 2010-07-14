module ActiveResource
  #:nodoc:
  class ClientError < ActiveResource::ConnectionError
    
    # Extend client errors so that they annotate the response message with the details
    # from a JSON response.  LiquidPlanner sends back useful response bodies, so we might as well
    # use them if they are available.
    def initialize(response, message=nil)
      if !message && response['Content-Type']['application/json']
        details = ActiveSupport::JSON.decode(response.body)
        detailed_message = details['message']
        super response, detailed_message
      else
        super response, message
      end
    end
    
    # Return the default exception message with the extracted API message as well if available
    def to_s
      str = super
      str << "  #{@message}" if @message
      str
    end
  end
end