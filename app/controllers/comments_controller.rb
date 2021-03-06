class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  authorize_resource

  def show_comments_toggle
    @week_id = params[:week_id]
    lecture_module = Week.find(@week_id).lecture_module
    @weeks = lecture_module.weeks
    profile = Profile.find_by(user_id: current_user.id)
    profile = profile.change_show_comments_state
    respond_to do |format|
      if profile.save
        format.html { redirect_back fallback_location: root_path, notice: 'Profile was successfully updated.' }
        format.js
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Profile could not be updated.' }
      end
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.week.lecture_module, notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @original_body = @comment.body
    if params[:body] != @comment.body
      respond_to do |format|
        if @comment.update(body: params[:body])
          format.js
        else
          format.js { render :template => 'comments/update_empty.js.erb' }
        end
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Comment was successfully destroyed.' }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:week_id, :user_id, :body)
    end
end
