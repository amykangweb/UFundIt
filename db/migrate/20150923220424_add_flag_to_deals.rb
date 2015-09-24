class AddFlagToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :flag, :boolean
  end
end
