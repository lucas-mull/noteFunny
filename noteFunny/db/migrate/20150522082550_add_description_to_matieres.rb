class AddDescriptionToMatieres < ActiveRecord::Migration
  def change
    add_column :matieres, :description, :string
  end
end
