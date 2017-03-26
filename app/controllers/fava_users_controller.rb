class FavaUsersController < ApplicationController

  layout 'userauth'
  before_action :set_fava_user, only: [:show, :edit, :update, :destroy]


  # GET /fava_users
  # GET /fava_users.json
  def index
    @fava_users = FavaUser.all
  end

  # GET /fava_users/1
  # GET /fava_users/1.json
  def show
  end

  # GET /fava_users/new
  def new
    @fava_user = FavaUser.new
  end

  # GET /fava_users/1/edit
  def edit
  end

  # POST /fava_users
  # POST /fava_users.json
  def create
    @fava_user = FavaUser.new(user_params)

    respond_to do |format|
      if @fava_user.save
        UserMailer.account_activation(@fava_user).deliver_now
        flash[:info] = "Please check your email to activate your account."
        format.html {redirect_to root_url}
      else
        format.html { render :new }
        format.json { render json: @fava_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
        params.require(:fava_user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
    end


  # PATCH/PUT /fava_users/1
  # PATCH/PUT /fava_users/1.json
  def update
    respond_to do |format|
      if @fava_user.update(fava_user_params)
        format.html { redirect_to @fava_user, notice: 'Fava user was successfully updated.' }
        format.json { render :show, status: :ok, location: @fava_user }
      else
        format.html { render :edit }
        format.json { render json: @fava_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fava_users/1
  # DELETE /fava_users/1.json
  def destroy
    @fava_user.destroy
    respond_to do |format|
      format.html { redirect_to fava_users_url, notice: 'Fava user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fava_user
      @fava_user = FavaUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fava_user_params
      params.require(:fava_user).permit(:first_name, :last_name, :email, :phone)
    end
end
