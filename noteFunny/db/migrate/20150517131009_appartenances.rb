class Appartenances < ActiveRecord::Migration
  def self.up
  	create_table :appartenances  do |t|
  		t.column :matiere_id, :integer, :null => false
  		t.column :etudiant_id, :integer, :null => false
  	end
  end


  def self.down
  	drop_table :appartenances
  end
end


