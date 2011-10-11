class AddAgileFrance2012 < Mongoid::Migration
  def self.up
    Conference.create(name: 'Agile France', edition: '2012')
  end

  def self.down
    Conference.where(name: 'Agile France', edition: '2012').destroy_all
  end
end