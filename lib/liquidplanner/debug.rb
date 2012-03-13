module LiquidPlanner
  # Print out all the outgoing requests from the LiquidPlanner API
  def self.watch_requests!(&block)
    ActiveSupport::Notifications.subscribe('request.active_resource') do |name, time, stamp, id, payload|
      method = payload[:method]
      request = payload[:request_uri]
      
      if block
        block.call(method, request, payload)
      else
        puts "[#{method}] #{request}"
      end
      
    end
  end
end