class RemoveCountFromAdds < ActiveRecord::Migration
  def change
    remove_column :adds, :count, :integer
  end
end
