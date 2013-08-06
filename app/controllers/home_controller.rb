class HomeController < ApplicationController

  def index

    @post = Post.new
  	
    @users = User.all

    @followings = Followings.find_all_by_user_id(current_user.id)
    @posts_follow = []
    @followings.each do |follow|
      @post_follow = Post.find_all_by_user_id(follow.follower_id)
      if !@post_follow.blank?
        @post_follow.each do |post|
          @posts_follow << post
        end
      end
    end 

  end


   def search
    conditions = {}
    %w(email first_name last_name posts).each do |i|
      i = i.to_sym
      next unless params[i]
      conditions[i] = params[i]
    end
    @users = User.search params[:search_parameter], :conditions => conditions,:star => true # Automatic wildcard search
    
    @posts = Post.find_all_by_user_id(current_user.id)
    @post = Post.new
    @followings = Followings.find_all_by_user_id(current_user.id)
    @posts_follow = []
    @followings.each do |follow|
      @post_follow = Post.find_all_by_user_id(follow.follower_id)
      if !@post_follow.blank?
        @post_follow.each do |post|
          @posts_follow << post
        end
      end
    end 

    render "index"                                # *search_term*
  end

  def follow_me
  	following = Followings.create(:user_id => current_user.id,:follower_id=> params[:id])
  	redirect_to home_index_path
  end	

  def un_follow_me
	  follow_me = Followings.find_by_follower_id(params[:id])
    follow_me.destroy
  	redirect_to home_index_path  
  end	

  def my_followers
    @followers = Followings.find_all_by_follower_id(current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def my_followings
    @followings = Followings.find_all_by_user_id(current_user.id)
    respond_to do |format|
      format.js
    end
  end

end
