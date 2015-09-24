class RestoreFlagColumnToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :flag, :boolean, default: false
  end
end
