class SessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create_oauth]
 
  def new
	new_oauth
	#session[:user_id] = 1
	#redirect_to :controller => 'groups'
  end 
  
  def new_oauth
	consumer = get_consumer
    next_url = "http://cageball.heroku.com/sessions/create_oauth"
    consumer = get_consumer
    request_token = consumer.get_request_token({:oauth_callback => next_url}, {:scope => "https://www.google.com/m8/feeds/"})
    session[:oauth_secret] = request_token.secret
    redirect_to request_token.authorize_url 
  end
 
  def create_oauth
	begin
		require 'xmlsimple'
		request_token = OAuth::RequestToken.new(get_consumer, params[:oauth_token], session[:oauth_secret])
		access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
		xml = XmlSimple.xml_in(access_token.get("https://www.google.com/m8/feeds/contacts/default/full/").body)
		email = xml["author"].first["email"].first
		user = Player.find_by_email(email)
		if user 
			user.save
			session[:user_id] = user.id
			redirect_to :controller => 'timeslots'
		else
			render :text => "You are not allowed here", :status => 403
		end
	rescue
		print "An error occured: ", $!, "\n" 
		render :text => "This is an error", :status => 500
	end
  end
 
  def delete
    reset_session
    flash[:notice] = "You have been logged out"
    redirect_to :action => 'new'
  end
end