class AddDealIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :deal, index: true
  end
end
