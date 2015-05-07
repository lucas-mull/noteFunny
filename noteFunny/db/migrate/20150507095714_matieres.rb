class Matieres < ActiveRecord::Migration
  def self.up
  	create_table:  do |t|
  		t.column: titre, :string, :limit => 20, :null => false
  		t.column: debut, :date, :null => false
  		t.column: fin, :date, :null => false
  		t.column: enseignant_id, :integer, :null => false
  	end
  end


  def self.down
  	drop_table: matieres
  end
end


