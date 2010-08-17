class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string :title
      t.string :description
      t.integer :conference_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
