module ConferencesHelper
  def introduce(conference)
    "#{conference.name}/#{conference.edition}"
  end
end
