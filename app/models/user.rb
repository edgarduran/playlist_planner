class User < ActiveRecord::Base

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, user_name: oauth.info.id)
    user.display_name   = oauth.info.display_name
    user.email          = oauth.info.email
    user.user_name      = oauth.info.id
    user.image          = oauth.info.images.first.url
    user.token          = oauth.credentials.token
    user.refresh_token  = oauth.credentials.refresh_token
    user.save

    user
  end
end
