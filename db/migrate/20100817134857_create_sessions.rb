class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string :title
      t.text :description
      t.references :conference
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
