class Epreuves < ActiveRecord::Migration
  def self.up
  	create_table :epreuves do |t|
  		t.column :titre, :string, :limit => 20, :null => false
  		t.column :date, :date, :null => false
  		t.column :matiere_id, :integer, :null => false
  	end
  end


  def self.down
  	drop_table :epreuves
  end
end



