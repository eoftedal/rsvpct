class SessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create_oauth]
 
  def new
	consumer = get_consumer
    next_url = "http://cageball.heroku.com/sessions/create_oauth"
    consumer = get_consumer
    request_token = consumer.get_request_token({:oauth_callback => next_url}, {:scope => "https://www.google.com/m8/feeds/"})
    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url 
  end
 
  def create_oauth
	puts "1"
    request_token = OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
	puts "2"
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
	puts "3"
    xml = XmlSimple.xml_in(access_token.get("https://www.google.com/m8/feeds/contacts/default/full/").body)
	puts "4"
    email = xml["author"].first["email"].first
	puts "5"
    user = Player.find_or_create_by_email(email)
	puts "6"
    user.name = xml["author"].first["name"].first
	puts "7"
    user.oauth_token  =  access_token.token
	puts "8"
    user.oauth_secret =  access_token.secret
	puts "9"
     user.save
	puts "10"
    session[:user_id] = user.id
	puts "11"
    redirect_to :controller => 'timeslots'
  end
 
  def delete
    reset_session
    flash[:notice] = "You have been logged out"
    redirect_to :action => 'new'
  end
end