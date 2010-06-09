class CommentsController < ApplicationController  
  def create
    @commentable      = find_commentable
    @comment          = @commentable.comments.build(params[:comment])
    @comment.user_id  = current_user.id
    
    respond_to do |format|
      if @comment.save!
        format.html { redirect_to(commentable_url, :notice => 'Comentario creado con exito') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :nothing => true }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def commentable_url
    send(@commentable.class.to_s.downcase + "_path", @commentable.name)
  end
  
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end  
end
