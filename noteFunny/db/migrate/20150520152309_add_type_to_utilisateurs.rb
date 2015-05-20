class AddTypeToUtilisateurs < ActiveRecord::Migration
  def change
    add_column :utilisateurs, :type, :string
  end
end
