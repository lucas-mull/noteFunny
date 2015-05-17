class Resultats < ActiveRecord::Migration
  def self.up
  	create_table :resultats  do |t|
  		t.column :valeur, :integer
  		t.column :etudiant_id, :integer, :null => false
  		t.column :epreuve_id, :integer, :null => false
  	end
  end


  def self.down
  	drop_table :resultats
  end
end


