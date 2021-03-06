class User < ActiveRecord::Base
  has_many :requests

  def self.find_or_create_from_oauth(oauth)
    user = User.find_or_create_by(provider: oauth.provider, user_name: oauth.info.id)
    user.display_name   = oauth.info.display_name
    user.email          = oauth.info.email
    user.user_name      = oauth.info.id
    user.image          = if oauth.info.images.first == nil
                            "http://www.nilayaheights.com/wp-content/themes/nilayaheights/images/profile-default-male.png"
                          else
                            oauth.info.images.first.url
                          end
    user.token          = oauth.credentials.token
    user.refresh_token  = oauth.credentials.refresh_token
    user.save

    user
  end
end
