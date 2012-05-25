module ActiveResource
  class Connection

    # get a raw response (not just the decoded response body);
    # used for non-standard responses (e.g. binary / file data)
    def get_raw(path, headers = {})
      with_auth { request(:get, path, build_request_headers(headers, :get, self.site.merge(path))) }
    end

    # force accept-encoding request header to "gzip"
    # so that server compresses its response
    #
    def enable_gzip
      default_header['accept-encoding'] = 'gzip'
    end

    # transparently decompress response body,
    # if content-encoding indicates it is gzipped
    #
    alias_method :handle_response_without_gzip, :handle_response
    def handle_response(response)
      if 'gzip' == response['content-encoding']
        response.body = Zlib::GzipReader.new(StringIO.new(response.body)).read
        response.delete('content-encoding')
      end
      handle_response_without_gzip(response)
    end

  end
end
