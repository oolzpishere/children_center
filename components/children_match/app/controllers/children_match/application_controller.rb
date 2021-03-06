module ChildrenMatch
  class ApplicationController < ActionController::Base
    include Shared::Controller::Layout

    protect_from_forgery with: :exception , if: Proc.new { |c| c.request.format != 'application/json' }


    # 调用微信授权获取openid
    def invoke_wx_auth
      if params[:state].present? && params[:state] == state \
         || session['openid'].present?
        return # 防止进入死循环授权
      end
      # 生成授权url，再进行跳转
      sns_url =  oauth.get_code_uri
      redirect_to sns_url and return
    end

    # 在invoke_wx_auth中做了跳转之后，此方法截取
    def get_wechat_sns
      # params[:state] 这个参数是微信特定参数，所以可以以此来判断授权成功后微信回调。
      if session[:openid].blank? && params[:state].present? && params[:state] == state
        sns_info = ChildrenMatch::WechatAuth::Client.new(code: params[:code]).json_hash
        Rails.logger.debug("Weixin oauth2 response: #{sns_info}")
        # 重复使用相同一个code调用时：
        if sns_info["errcode"] != "40029"
          session[:openid] = sns_info["openid"]
        end
      end
    end

    private
      def state
        oauth.state
      end

      def oauth
        ChildrenMatch::WechatAuth::Oauth.new(redirect_uri: request.url)
      end

      def authenticate
        authenticate_or_request_with_http_digest do |username|
          USERS[username]
        end
      end

  end
end
