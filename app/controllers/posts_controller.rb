class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.find_all_by_user_id(current_user.id)

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

    respond_to do |format|
      format.js 
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.js
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /posts
  # POST /posts.json
  def create
 
    @post = Post.new(params[:post])
    @post.user_id = current_user.id

    @posts = Post.find_all_by_user_id(current_user.id)

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

    respond_to do |format|
      if @post.save  
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    @users = User.all
      
    @posts = Post.find_all_by_user_id(current_user.id)

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


    respond_to do |format| 
      format.js
    end
  end
end
