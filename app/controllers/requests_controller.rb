class RequestsController < ApplicationController
require 'date'

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
          to_destroy = []
          j = 0
          for i in 0..@requests.length - 1
            if check_timed_out(@requests[i])
              to_destroy[j] = @requests[i]
              j = j + 1
            end
          end
          for k in 0..to_destroy.length - 1
            to_destroy[k].destroy
          end
            
      else
        redirect_to root_path
      end
  end

  def completed
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:status => 2).order('updated_at DESC')
      p @requests
    else
      redirect_to root_path
    end
  end


  def my_requests
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @requests = Request.where(:fava_user_id => fava_user.id, :status => [0, 1]).all.order('updated_at DESC')
      to_destroy = []
          j = 0
          for i in 0..@requests.length - 1
            if check_timed_out(@requests[i])
              to_destroy[j] = @requests[i]
              j = j + 1
            end
          end
          for k in 0..to_destroy.length - 1
            to_destroy[k].destroy
          end
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
      
      p @requests
    else
      redirect_to root_path
    end
  end


  def complete_delivery
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @request = Request.find_by_id(params[:request])
      @msg = params[:msg]
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
        p request.tip.to_f
        fava_user.save
        if !request.size_id.nil?
          change_in_points = Size.find_by_id(request.size_id).price + request.tip.to_f
          requester.update(fava_points: requester.fava_points - change_in_points)
          requester.save!
        else
          change_in_points = FoodItem.find_by_id(request.food_item_id).price + request.tip.to_f
          requester.update(fava_points: requester.fava_points - change_in_points)
          requester.save!
        end
        redirect_to my_deliveries_path
      else
        redirect_to controller: 'requests', action: 'complete_delivery', request: request.id, msg: 1
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
          current_time = DateTime.now.strftime("%H:%M")
          current_hour = current_time[0..1]
          current_minute = current_time[3..4]
          if !((current_hour+current_minute) >= @restaurant.open_hour and (current_hour+current_minute) <= @restaurant.close_hour)
            @msg = true
          end

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
          if(@food_item.sizes.size > 0)
            @size = @food_item.sizes
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

  def delete_request
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
        @fava_user = fava_user
        @request = Request.find_by_id(params[:request])
        @request.destroy
        redirect_to my_requests_path

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
          @msg = params[:msg]
          @restaurant = Restaurant.find_by_id(@food_item.restaurant_id)
          @sides = @food_item.sides
          @sizes = @food_item.sizes
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
        
        @side = Side.find_by_id(request_params[:side_id])
        @size = Size.find_by_id(request_params[:size_id])
        current_time = DateTime.now.strftime("%H:%M")
        current_hour = current_time[0..1]
        current_minute = current_time[3..4]

        if !is_number?(request_params[:tip]) or request_params[:tip].nil?
          redirect_to controller: 'requests', action: 'order', food_item: @food_item.id, msg: 1
        elsif request_params[:location].nil? or request_params[:location].length == 0
          redirect_to controller: 'requests', action: 'order', food_item: @food_item.id, msg: 2
        elsif !(current_hour + current_minute >= @restaurant.open_hour and current_hour + current_minute <= @restaurant.close_hour)
          redirect_to controller: 'requests', action: 'order', food_item: @food_item.id, msg: 3
        elsif @food_item.price.to_f + request_params[:tip].to_f > @fava_user.fava_points
            redirect_to controller: 'requests', action: 'order', food_item: @food_item.id, msg: 4
        else

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
          flash.now[:info] = "Your request has been posted"
          flash.keep
          redirect_to timeline_path
        end
        else
          raise "error"
        end
  end

  def profile
      fava_user = FavaUser.find_by_id(session[:fava_user_id])
      if fava_user && fava_user.activated
          @fava_user = fava_user
          @fname = @fava_user.first_name
          @lname = @fava_user.last_name
          @email = @fava_user.email
          @user_since = @fava_user.created_at
          @balance = @fava_user.format_points()
          @num_post = Request.where(:fava_user_id => fava_user.id).count
          @num_dev = Request.where(:claimer => fava_user.id, :status => 2).count
          if Request.where(:fava_user_id => fava_user.id).all.size > 0
            @fav_items = Request.where(:fava_user_id => fava_user.id).group(:food_item_id).count.sort {|a,b| a[1] <=> b[1]}.reverse.first(3)
          end
      else
        redirect_to root_path
      end
  end

  def change_password
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

  def submit_new_password
    fava_user = FavaUser.find_by_id(session[:fava_user_id])

      if fava_user && fava_user.activated
          @fava_user = fava_user
          p @fava_user.pin
          p pin_params[:curr_pin]
          if @fava_user.pin != pin_params[:curr_pin]
            flash.now[:danger] = 'Invalid pin.'
            render 'change_password'
          elsif pin_params[:new_pin]!=pin_params[:new_pin_confirmation]
            flash.now[:danger] = "Pins don't match."
            render 'change_password'
          elsif pin_params[:new_pin].length != 4
            flash.now[:danger] = "Pin must be 4 digits long."
            render 'change_password'
          elsif !is_number? (pin_params[:new_pin])
            flash.now[:danger] = "Pin must contain only digits."
            render 'change_password'
          else
          @fava_user.update(pin: pin_params[:new_pin])
          @fava_user.save!
          flash.now[:notice] = "Pin successfully changed!"
          redirect_to profile_path
        end

      else
        redirect_to root_path
      end
  end

  def top_sellers
    fava_user = FavaUser.find_by_id(session[:fava_user_id])
    if fava_user && fava_user.activated
      @fava_user = fava_user
      @top_food_items = Request.group(:food_item_id).count.sort{|a,b| a[1] <=> b[1]}.reverse.first(5)
      #@top_delivery_locations = Request.group(:location).count.sort{}{|a,b| a[1] <=> b[1]}.reverse.first(3)
      top_restaurants = []
      Request.all.each do |r|
        rest = Restaurant.find_by_id(FoodItem.find_by_id(r.food_item_id).restaurant_id)
        if top_restaurants[rest.id].nil?
          top_restaurants[rest.id] = 1
        else
          top_restaurants[rest.id] = top_restaurants[rest.id] + 1
        end
      end
      for i in 0..top_restaurants.size-1
        if top_restaurants[i].nil?
          top_restaurants[i] = 0
        end
      end
      @top_rests = [[]]
      for i in 0..top_restaurants.size-1
        @top_rests[i] = []
        @top_rests[i][0] = i
        @top_rests[i][1] = top_restaurants[i]
      end
      @top_rests = @top_rests.sort{|a,b| a[1] <=> b[1]}.reverse.first(5)
    else
      redirect_to root_path
    end

  end

  def check_timed_out(request)
    if !request.nil?
        current_time = DateTime.now.strftime("%H:%M")
        current_hour = current_time[0..1]
        current_minute = current_time[3..4]
        requested_hour = request.created_at.to_s[11..12]
        requested_minute = request.created_at.to_s[14..15]
        if (current_hour + current_minute).to_f >= (requested_hour + requested_minute).to_f + 2
          return true
        end
      end
      return false
  end


  def request_params
      params.require(:request).permit(:food_item_id, :restaurant_id, :location, :notes, :tip, :side_id, :size_id)
  end

  def pin_params
    params.require(:fava_user).permit(:curr_pin, :new_pin, :new_pin_confirmation)
  end
end