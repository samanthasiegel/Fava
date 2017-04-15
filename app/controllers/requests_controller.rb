class RequestsController < ApplicationController
layout 'internal'
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @requests = Request.all
    else
      redirect_to root_path
    end
  end

  def new
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
  	   @request = Request.new
  	   @restaurants = Restaurant.all
    else
        redirect_to root_path
    end
  end
  
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @requests = Request.all
      else
        redirect_to root_path
      end
  end

  def my_requests
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @requests = Request.where(:fava_user_id => fava_user.id)
    else
      redirect_to root_path
    end
  end


  def list_restaurants
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @restaurants = Restaurant.all
      else
        redirect_to root_path
      end
  end

  def list_food
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @restaurant = Restaurant.find_by_id(params[:restaurant])
          @food_items = FoodItem.where(:Restaurant_id => params[:restaurant])

      else
        redirect_to root_path
      end
  end


  def food_item_profile
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @food_item = FoodItem.find_by_id(params[:food_item])
          @restaurant = Restaurant.find_by_id(@food_item.Restaurant_id)
          @size_not_empty = (@food_item.size != "\\N")
          @allergy_not_empty = (@food_item.allergy_info != "\\N")

      else
        redirect_to root_path
      end
  end

  def accept_request
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @request = Request.find_by_id(params[:request])
    else
      redirect_to root_path
    end
  end

  def confirm_accept
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      request = Request.find_by_id(params[:request])
      if request.fava_user_id == fava_user.id
        redirect_to root_path
      else
        request.update(claimer: fava_user.id)
        request.update(status: 1)
        request.save
        redirect_to timeline_path
      end
    else
      redirect_to root_path
    end
  end

  def filter
    
  end

  def filter_by_cat
       @food_items = FoodItem.where(:category => params[:category])
          @category = params[:category]
  end

  def order
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        if params[:food_item] != nil
          @food_item = FoodItem.find_by_id(params[:food_item])
          @restaurant = Restaurant.find_by_id(@food_item.Restaurant_id)
          @sides = Side.where(:food_item_id => @food_item.id)
          @request = Request.new
        elsif request_params[:food_item_id] != nil
          raise "error"
        else
          raise "error"
        end
      else
        redirect_to root_path
      end
  end


  # create post
  def create
      if request_params[:food_item_id] != nil
        @fava_user = FavaUser.find_by_id(session[:fava_user_id])
        @restaurant = Restaurant.find_by_id(request_params[:restaurant_id])
        @food_item = FoodItem.find_by_id(request_params[:food_item_id])
        #find a way to save sides
        #fix this!!
        @side = Side.find_by_id(request_params[:side_id])
        if(!@side.nil?)
          @request = Request.new(:fava_user_id => @fava_user.id, :food_item_id => @food_item.id, :location => request_params[:location], :tip => request_params[:tip], :notes => request_params[:notes], :status => 0, :side_id => @side.id)
          @request.save
          @request.errors.full_messages
        else
          @request =Request.new(:fava_user_id => @fava_user.id, :food_item_id => @food_item.id, :location => request_params[:location], :tip => request_params[:tip], :notes => request_params[:notes], :status => 0)
          @request.save
          @request.errors.full_messages
        end
      else
        raise "error"
      end
      respond_to do |format|
        flash.now[:info] = "Your request has been posted"
        flash.keep
        format.html {redirect_to timeline_path}
      end

   #  restaurant_id = Restaurant.where(:name => params[:restaurant_name])
   #  food_id = FoodItem.where(:food_name => params[:food_name], :Restaurant_id => restaurant_id)
   #  @post = Post.new(FoodItem_id: food_id, )
	  # respond_to do |format|
	  #   flash.now[:info] = "Your request has been posted"
	  #   format.html {redirect_to timeline_path}
	  #  end
  end


  def request_params
      params.require(:request).permit(:food_item_id, :restaurant_id, :location, :notes, :tip, :side_id)

  end
end
