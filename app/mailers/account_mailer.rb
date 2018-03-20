class AccountMailer < ApplicationMailer
  default from: 'Info@BankAndTrust.com'
	
  def welcome_email(user, account)
    @user = user
    @account = account
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Bank and Trust!')
  end

  def update_email(user, account, transaction, amount, previous_balance)
    @user = user
    @account = account
    @url  = 'http://localhost:3000/'
    @transaction = transaction
    @amount = amount
    @previous_balance = previous_balance
    mail(to: @user.email, subject: 'Account Update')
  end

end
