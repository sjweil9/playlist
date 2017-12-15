class AddCountToAdds < ActiveRecord::Migration
  def change
    add_column :adds, :count, :integer
  end
end
