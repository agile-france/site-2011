module Party::ConferencesHelper
  def introduce(conference)
    "#{conference.name}/#{conference.edition}"
  end
end
