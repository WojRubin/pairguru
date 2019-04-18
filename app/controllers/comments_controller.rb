class CommentsController < ApplicationController

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
      
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.movie, notice: 'Comment was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @user = current_user
    @comment = @user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.js   { }
      format.json { }
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body, :movie_id)
    end
end
