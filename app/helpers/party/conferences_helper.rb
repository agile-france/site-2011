module Party::ConferencesHelper
  def conference_path(options)
    "conferences/#{options[:name]}/#{options[:edition]}"
  end
end
