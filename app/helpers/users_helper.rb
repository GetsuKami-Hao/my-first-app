module UsersHelper

	def get_form_hash(className,place)
		{ class: "#{className}" , placeholder: "#{place}" }
	end
	  # 返回指定用户的 Gravatar
  def gravatar_for(user, options = {size: 80} )
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
  end
end
