module Party
  module UrlHelper
    def conference_path_for(options)
      "conferences/#{options[:name]}/#{options[:edition]}"
    end
  end
end