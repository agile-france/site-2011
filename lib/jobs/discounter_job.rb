class DiscounterJob
  @queue = :registration

  def self.perform
    speakers = CSV.parse(File.read("db/csv/#{Rails.env}/speakers.csv"))
    speakers.each do |s|
      u = User.identified_by_email(s[2])
      ohai("no such speaker in users : #{s}") and next unless u
      unless u.registrations.empty?
        ohai("we ve got a problem with : #{u.email}")
      end
    end
    nil
  end

  def self.ohai(s)
    s.tap{puts s}
  end
end