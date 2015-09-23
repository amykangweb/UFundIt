class AddDealIdToUpdates < ActiveRecord::Migration
  def change
    add_reference :updates, :deal, index: true
  end
end
