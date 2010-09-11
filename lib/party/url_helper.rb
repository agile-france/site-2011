module Party
  module UrlHelper
    def conference_path(options)
      "conferences/#{options[:name]}/#{options[:edition]}"
    end
  end
end