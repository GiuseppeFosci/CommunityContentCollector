class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    
    def show
      @post= Post.find(params[:id])
      @comments= @post.comments.paginate(page: params[:page], per_page: 3)
      @comment = Comment.new 
    end

    def edit
      @post=Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
        if @post.update(post_params)
          flash[:success] = "Post aggiornato"
          redirect_to @post
        else
          render 'edit', status: :unprocessable_entity
        end
    end

    def create
        @post = current_user.posts.build(post_params)

        @post.files.attach(params[:post][:files])
        if @post.save
            flash[:success] = "Post creato!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home', status: :unprocessable_entity
        end
    end
    
    def show_cat
      @posts = Post.where("category LIKE ?", cat_params[:cat]).paginate(page: params[:page])
    end

    def destroy
        @post.destroy
        flash[:success] = "Post eliminato"   
        if request.referrer.nil?
            redirect_to root_url, status: :see_other
        else
            redirect_to request.referrer, status: :see_other
        end
    end
    
    def search_post
      @posts = Post.where("category LIKE ? AND content LIKE ?", params[:category], "%" + params[:content] + "%").paginate(page: params[:page]) 
    end
    
    private
    
    def cat_params
        params.permit(:cat)
    end

    def post_params
        params.require(:post).permit(:content, :category, :file => [])
    end
    
    

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @post.nil?
    end

end
