class RenameFollowrequestsToFollowRequests < ActiveRecord::Migration[7.1]
  def change
    rename_table :followrequests, :follow_requests
  end
end
