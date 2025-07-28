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
      redirect_to posts_index_path, notice: "投稿しました"
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
  end

  def destroy
  end

  private
  def set_current_user
    @user = current_user
  end

  def set_room
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to root_path, alert: "権限がありません。"
    end
  end
end
