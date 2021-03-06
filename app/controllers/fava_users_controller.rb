class FavaUsersController < ApplicationController


  layout 'userauth', :only => [:new, :create, :update, :destroy, :index, :show, :confirm]
  before_action :set_fava_user, only: [:show, :edit, :update, :destroy]


  # GET /fava_users
  # GET /fava_users.json
  def index
    @fava_users = FavaUser.all
    fava_user = FavaUer.find_by_id(session[:fava_user_id])
  end

  # GET /fava_users/1
  # GET /fava_users/1.json
  def show
  end

  def confirm
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

    @fava_user.update(fava_points: 20)
    respond_to do |format|
      if @fava_user.save
        UserMailer.account_activation(@fava_user).deliver_now
        flash.now[:info] = "Please check your email to activate your account."
        format.html {redirect_to confirm_path}
      else
        format.html { render :new }
        format.json { render json: @fava_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def getting_started
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user

    else
      redirect_to root_path
    end
  end

  def incorrect_pin
   fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
    else
      redirect_to root_path
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end

  def submit_pin
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated 
      if pin_params[:pin].length != 4 or !is_number?(pin_params[:pin])
        redirect_to incorrect_pin_path
      else
        fava_user.update(pin: pin_params[:pin])
        fava_user.save
        redirect_to timeline_path
      end
    else
      redirect_to root_path
    end
  end

  private
    def pin_params
      params.require(:fava_user).permit(:pin)

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
      params.require(:fava_user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
    end
end
