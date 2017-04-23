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
       @fava_user = fava_user
  	   @request = Request.new
  	   @restaurants = Restaurant.all
    else
        redirect_to root_path
    end
  end
  
  def index
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @requests = Request.all.order('updated_at DESC')
      else
        redirect_to root_path
      end
  end

  def completed
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:status => 2).order('updated_at DESC')
    else
      redirect_to root_path
    end
  end


  def my_requests
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:fava_user_id => fava_user.id, :status => [0, 1]).all.order('updated_at DESC')
    else
      redirect_to root_path
    end
  end

  def my_history
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:fava_user_id => fava_user.id, :status => 2)
    else
      redirect_to root_path
    end
  end

  def my_deliveries
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:claimer => fava_user.id).order(:status, :created_at)
    else
      redirect_to root_path
    end
  end


  def complete_delivery
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @request = Request.find_by_id(params[:request])
    else
      redirect_to root_path
    end
  end

  def check_pin
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      request = Request.find_by_id(params[:request])
      requester = FavaUser.find_by_id(request.fava_user_id);
      pin = params[:pin]
      p pin
      p requester.pin
      if requester.pin == pin
        request = Request.find_by_id(params[:request])
        request.update(status: 2)
        request.save
        fava_user.update(fava_points: fava_user.fava_points + request.tip.to_f)
        fava_user.save
        if !request.size_id.nil?
          change_in_points = Size.find_by_id(request.size_id).price + request.tip.to_f
          requester.update(fava_points: requester.fava_points - change_in_points)
          requester.save!
        else
          change_in_points = FoodItem.find_by_id(request.food_item_id) + request.tip.to_f
          requester.update(fava_points: requester.fava_points - change_in_points)
          requester.save!
        end
        redirect_to my_deliveries_path
      else
        redirect_to timeline_path
      end
    else
      redirect_to root_path
    end
  end

  # def complete_delivery
  #   fava_user = FavaUser.find_by_id(session[:fava_user_id])
  #   if fava_user && fava_user.activated
  #     request = Request.find_by_id(params[:request])
  #     request.update(status: 2)
  #     request.save
  #     redirect_to my_deliveries_path
  #   else
  #     redirect_to root_path
  #   end
  # end



  def list_restaurants
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @restaurants = Restaurant.all
      else
        redirect_to root_path
      end
  end

  def list_food
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @restaurant = Restaurant.find_by_id(params[:restaurant])
          @food_items = FoodItem.where(:restaurant_id => params[:restaurant])

      else
        redirect_to root_path
      end
  end


  def food_item_profile
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @food_item = FoodItem.find_by_id(params[:food_item])
          if @food_item.price > fava_user.fava_points
          	@broke_message = true
          else
          	@broke_message = false
          end
          p @broke_message
          @restaurant = Restaurant.find_by_id(@food_item.restaurant_id)
          if(Size.where(:food_item_id => @food_item.id).all.size > 0)
            @size = Size.where(:food_item_id => @food_item.id).all
          end
          @allergy_not_empty = (@food_item.allergy_info != "\\N")

      else
        redirect_to root_path
      end
  end

  def accept_request
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @request = Request.find_by_id(params[:request])
    else
      redirect_to root_path
    end
  end

  def confirm_accept
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user =fava_user
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
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
      else
        redirect_to root_path
      end
  end

  def filter_by_cat
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
        category = Category.find_by_id(params[:category])
        @food_items = FoodItem.where(:category => category.name)
        @category = category.name
      else
        redirect_to root_path
      end
  end

   def search_by_keyword
     fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
      else
        redirect_to root_path
      end
  end

  def search
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
        @search = params[:search]
        @food_items = FoodItem.where("food_name like ?", "%#{@search}%")
      else
        redirect_to root_path
      end
  end

  def order
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
        if params[:food_item] != nil
          @food_item = FoodItem.find_by_id(params[:food_item])
          @restaurant = Restaurant.find_by_id(@food_item.restaurant_id)
          @sides = Side.where(:food_item_id => @food_item.id)
          @sizes = Size.where(:food_item_id => @food_item.id)
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
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if request_params[:food_item_id] != nil
        @fava_user = FavaUser.find_by_id(session[:fava_user_id])
        @restaurant = Restaurant.find_by_id(request_params[:restaurant_id])
        @food_item = FoodItem.find_by_id(request_params[:food_item_id])
        #find a way to save sides
        #fix this!!
        @side = Side.find_by_id(request_params[:side_id])
        @size = Size.find_by_id(request_params[:size_id])
        if(!@side.nil?)
          @request = Request.new(:fava_user_id => @fava_user.id, :food_item_id => @food_item.id, :location => request_params[:location], :tip => request_params[:tip], :notes => request_params[:notes], :status => 0, :side_id => @side.id)
          if(!@size.nil?)
            @request.size_id = @size.id
          end
          @request.save
          @request.errors.full_messages
        else
          @request =Request.new(:fava_user_id => @fava_user.id, :food_item_id => @food_item.id, :location => request_params[:location], :tip => request_params[:tip], :notes => request_params[:notes], :status => 0)
          if(!@size.nil?)
            @request.size_id = @size.id
          end
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
      params.require(:request).permit(:food_item_id, :restaurant_id, :location, :notes, :tip, :side_id, :size_id)

  end
end
