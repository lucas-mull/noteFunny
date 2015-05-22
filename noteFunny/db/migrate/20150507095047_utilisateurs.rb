class Utilisateurs < ActiveRecord::Migration
  def self.up
  	create_table :utilisateurs do |t|
  		t.column :nom, :string, :limit => 20, :null => false
  		t.column :prenom, :string, :limit => 20, :null => false
  		t.column :email, :string, :limit => 100, :null => false
  		t.column :password, :string, :limit => 50, :null => false
  	end
  end


  def self.down
  	drop_table :utilisateurs
end


