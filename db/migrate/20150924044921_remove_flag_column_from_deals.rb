class RemoveFlagColumnFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :flag
  end
end
