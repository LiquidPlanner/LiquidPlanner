module LiquidPlanner
  module Resources
    class Document < Luggage

      def self.upload_document( workspace_id, item_id, attached_file_path, options={} )
        file_name   = options[:file_name]   || File.basename(attached_file_path)
        description = options[:description] || ""
        content_type = options[:content_type] || "application/octet-stream"
        url         = site + "/api/workspaces/#{workspace_id}/treeitems/#{item_id}/documents"
        File.open(attached_file_path) do |handle|
          req = Net::HTTP::Post::Multipart.new( url.path, "document[file_name]"     => file_name,
                                                          "document[description]"   => description,
                                                          "document[attached_file]" => UploadIO.new(handle, content_type, attached_file_path)
                                              )
          req.basic_auth( user, password )
          res = nil
          begin
            res = Net::HTTP.start(url.host, url.port) do |http|
              http.use_ssl = true if url.scheme == "https" 
              http.request(req)
            end
          rescue Timeout::Error => e
            raise TimeoutError.new(e.message)
          rescue OpenSSL::SSL::SSLError => e
            raise SSLError.new(e.message)
          end
          connection.send(:handle_response, res)
          doc = new(format.decode(res.body))
        end
      end

      def download
        get_raw(:download)
      end

      def thumbnail
        get_raw(:thumbnail)
      end

    end
  end
end

