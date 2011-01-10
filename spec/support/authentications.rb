module Authentications
  module Twitter
    mattr_accessor :data
    @@data = {
      'provider' => 'twitter', 'uid' => "108267828",
      'user_info' => {
        'nickname' => 'thierryhenrio',
        'name' => 'thierry henrio',
        'location' => "",
        'image' => 'http://a2.twimg.com/profile_images/1142138959/me-kitchen-2010-10-11_normal.jpg',
        'description' => "",
        'urls' => {
          'Website' => '',
          'Twitter' => 'http://twitter.com/thierryhenrio',
          }
        },
        'credentials' => 'credentials',
        'extra' => 'raise ActionDispatch::Cookies::CookieOverflow'
      }
    end
    module Github
      mattr_accessor :data
      @@data = {
        "provider"=>"github", "uid"=>127846, 
        "user_info"=> {
          "nickname"=>"thierryhenrio", 
          "email"=>"thierry.henrio@gmail.com", 
          "name"=>"Thierry Henrio", 
          "urls"=>{
            "GitHub"=>"http://github.com/thierryhenrio", "Blog"=>nil
          }
        }
      }
    end
  end
