class FacebooksController < ApplicationController
  # GET /facebooks
  # GET /facebooks.xml
  SITE_URL="http://localhost:3000/"

  def index
    if session['access_token']
      @face='You are logged in! <a href="facebooks/logout">Logout</a>'
    else
      @face='<a href="facebooks/login">Login</a>'
    end
  end

  def login
    session['oauth'] = Koala::Facebook::OAuth.new(Facebook::APP_ID, Facebook::SECRET, SITE_URL + 'facebooks/callback')
    redirect_to session['oauth'].url_for_oauth_code( :permissions => "email, pages_manage_cta, pages_manage_instant_articles, public_profile, manage_pages, read_page_mailboxes")
  end

  def logout
    session['oauth'] = nil
    session['access_token'] = nil
    redirect_to '/facebooks/index'
  end

  def callback
    puts "session #{session['oauth']}"
    @oauth = Koala::Facebook::OAuth.new(Facebook::APP_ID, Facebook::SECRET, SITE_URL + 'facebooks/callback')  # ugly
    session['access_token'] = @oauth.get_access_token(params[:code])
    redirect_to '/facebooks/menu'
  end

  def menu
     @ok="you are welcome"
     if session['access_token']
       @face='You are logged in! <a href="/facebooks/logout">Logout</a><br>'
	@token =  session['access_token'] 
       @graph = Koala::Facebook::API.new(session["access_token"])
	@me = @graph.get_object("me")
	#@pages = @graph.get_object("me/accounts?type=page")

	puts "igrap #{@graph}"
	@pages = @graph.get_connections('me', 'accounts')
     else
       @face='<a href="/facebooks/login">Login</a>'
     end

  end
  
  def subscribre
    if session['access_token']
       @graph = Koala::Facebook::API.new(session["access_token"])

       # start api session as the page
       @page_token = @graph.get_page_access_token(params[:id])
       @page_graph = Koala::Facebook::API.new(@page_token)
       @t = @page_graph.put_connections('me','subscribed_apps');
     end


     redirect_to url_for(:controller => :facebooks, :action => :manage)
  end

  def unsubscribe
   if session['access_token']
       @graph = Koala::Facebook::API.new(session["access_token"])

       # start api session as the page
       @page_token = @graph.get_page_access_token(params[:id])
       @page_graph = Koala::Facebook::API.new(@page_token)
       @t = @page_graph.delete_connections('me','subscribed_apps');
     end

     redirect_to url_for(:controller => :facebooks, :action => :manage)
  end

  def manage
    if session['access_token']
       @token =  session['access_token']
       @graph = Koala::Facebook::API.new(session["access_token"])

       # start api session as the page
       @page_token = @graph.get_page_access_token(params[:id])
       @page_graph = Koala::Facebook::API.new(@page_token)

       # bring basic data for the page
       @me = @page_graph.get_object("me")

       # get subscription info
       @subs = @page_graph.get_connections('me', 'subscribed_apps');
     else
	# no token no fun
     end

  end
end
