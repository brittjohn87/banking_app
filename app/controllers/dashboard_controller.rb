class DashboardController < ApplicationController
  def all_accounts
  	if current_user.role == 'admin'
  		@accounts = Account.all
  	else 
  		@accounts = Account.where(user_id: current_user.id)
  	end
  end
end
