module WechatAuth
  class Client
    require 'net/http'

    attr_reader :code, :uri

    def initialize( ps = {} )
      @code = ps[:code]
      @uri = WechatAuth::Oauth.new.get_openid_uri(code)
    end

    # { "access_token":"ACCESS_TOKEN",
    #   "expires_in":7200,
    #   "refresh_token":"REFRESH_TOKEN",
    #   "openid":"OPENID",
    #   "scope":"SCOPE" }
    def json_hash
      JSON.parse(response_body)
    end

    def response_body
      Net::HTTP.get_response(URI(uri)).body
    end

  end
end
