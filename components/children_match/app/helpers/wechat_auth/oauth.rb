# coding: utf-8
module ChildrenMatch
  module WechatAuth
    class Oauth
      # require 'uri'
      attr_reader :appid, :secret, :redirect_uri, :scope, :state
      # code说明 ： code作为换取access_token的票据，每次用户授权带上的code将不一样，code只能使用一次，5分钟未被使用自动过期。
      def initialize( ps = {} )
        # params hash
        # appid default qianyan subscribe: wx2e050b0a651b968b sflx: wx37860e03b3e55945
        @appid = ENV["QIANYAN_APPID"]
        @secret = ENV["QIANYAN_APPSE"]
        @redirect_uri = encode_url(ps[:redirect_uri])
        # default snsapi_base
        @scope = ps[:scope] || "snsapi_base"
        @state = "wechat_auth"
      end

      def get_code_uri
        # URI.escape(snsapi.to_s)
        "https://www.sflx.com.cn/get-weixin-code.html?appid=#{appid}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"
        # direct authorize host name.
        # "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{appid}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"
      end

      def get_openid_uri(code)
        "https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{appid}&secret=#{secret}&code=#{code}&grant_type=authorization_code"
      end

      private

      def encode_url(url)
        ERB::Util.url_encode(url)
      end



      # def query
      #   qh = {appid: appid, redirect_uri: redirect_uri, response_type: :code, scope: scope, state: state}
      #   URI.encode_www_form qh
      # end

    end
  end
end
