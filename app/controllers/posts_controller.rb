class PostsController < ApplicationController
  before_action :set_current_user   #postアクションで、常に@user = current_userを渡す
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(met_object_id: params[:met_object_id])
  end

  def create
    @post = current_user.posts.build(params.require(:post).permit(:comment, :met_object_id))
    if @post.save
      redirect_to user_path(current_user), notice: "投稿しました"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(params.require(:post).permit(:comment))
      redirect_to user_path(current_user), notice: "投稿内容を更新しました"
    else
      flash.now[:alert] = "投稿内容の更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user), notice: "投稿を削除しました"
  end

  private
  def set_current_user
    @user = current_user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to root_path, alert: "権限がありません。"
    end
  end
end
