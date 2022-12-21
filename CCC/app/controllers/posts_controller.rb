class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user,only: :destroy
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home', status: :unprocessable_entity
        end
    end
    
    def destroy
        @post.destroy
        flash[:success] = "Micropost deleted"   
        if request.referrer.nil?
            redirect_to root_url, status: :see_other
        else
            redirect_to request.referrer, status: :see_other
    end
    
    end
    
    private
    
    def post_params
        params.require(:post).permit(:content)
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to root_url, status: :see_other if @post.nil?
    end



end
