class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_required
  #include AuthenticatedSystem
  
  def login_required
    if session[:user_id]
      @user ||= Player.find(session[:user_id])
      @access_token ||= OAuth::AccessToken.new(get_consumer, @user.oauth_token, @user.oauth_secret)
    else
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
 
  def get_consumer
	#require 'oauth'
	require 'rubygems' 
    require 'oauth/consumer'
    require 'oauth/signature/rsa/sha1'
	
     consumer = OAuth::Consumer.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'],
    {
		:site => "https://www.google.com",
		:request_token_path => "/accounts/OAuthGetRequestToken",
		:access_token_path => "/accounts/OAuthGetAccessToken",
		:authorize_path=> "/accounts/OAuthAuthorizeToken",
		:signature_method => "HMAC-SHA1"
	})
  end
end
