class AddEtatToUtilisateurs < ActiveRecord::Migration
  def change
    add_column :utilisateurs, :etat, :string
  end
end
