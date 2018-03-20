class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    authorize! :destroy, @account
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @histories = History.where(object_name: "Account", object_id: @account.id)
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    authorize! :update, @account
  end

  def deposit
    authorize! :update, @current_account 
    @current_account = Account.find(params[:id])
  end

  def withdrawal
    authorize! :update, @current_account
    @current_account = Account.find(params[:id])
  end

  def update_balance
    overdraft = false
    @account = Account.find(params[:id])
    current_balance = @account.balance
    if params[:transaction] == "deposit"
      @account.update(balance: current_balance + params[:balance].to_f)
    else
        if params[:balance].to_f > current_balance
          overdraft = true
        else
          @account.update(balance: current_balance - params[:balance].to_f)
        end
    end

    if overdraft == true
      redirect_to root_path, notice: "Withdrawal amount of $#{'%.2f' % params[:balance].to_f} exceeds your current balance of $#{current_balance}. Please enter a different amount."
    else
      AccountMailer.update_email(current_user, @account, params[:transaction], params[:balance], current_balance).deliver_now
      redirect_to root_path, notice: "Your #{params[:transaction]} of $#{'%.2f' % params[:balance]} has been made to account #{@account.id}."
    end
  end

  

  # POST /accounts
  # POST /accounts.json
  def create
    authorize! :create, @account
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        # mailer for welcome email
        AccountMailer.welcome_email(current_user, @account).deliver_now

        format.html { redirect_to root_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    authorize! :destroy, @account
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :balance, :account_type)
    end
end
