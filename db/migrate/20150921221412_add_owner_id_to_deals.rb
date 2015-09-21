class AddOwnerIdToDeals < ActiveRecord::Migration
  def change
    add_reference :deals, :owner, index: true
  end
end
