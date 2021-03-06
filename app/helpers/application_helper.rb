module ApplicationHelper
  

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
  
	def avatar_url(user,size)
    default_url = "#{root_url}default-user-icon.png"
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def filter
  	if params[:controller] == "maps"
  		"/maps/index"
  	else
  		'articles'
  	end
  end

  def marker_locations_for(articles)
    return nil if articles.blank?
    @hash = Gmaps4rails.build_markers(articles.dup) do |article, marker|
      marker.lat article.latitude
      marker.lng article.longitude
      marker.infowindow controller.render_to_string(:partial => "/articles/info_window", :locals => { :article => article})
    end
    @hash
  end
end
