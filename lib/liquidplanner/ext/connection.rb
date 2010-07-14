module ActiveResource
  class Connection

    # get a raw response (not just the decoded response body);
    # used for non-standard responses (e.g. binary / file data)
    def get_raw(path, headers = {})
      with_auth { request(:get, path, build_request_headers(headers, :get, self.site.merge(path))) }
    end

  end
end
