class KillExecutionsAndOrders < Mongoid::Migration
  def self.up
    %w(executions orders).map {|name| Mongoid.database.collection(name).drop}
  end

  def self.down
  end
end