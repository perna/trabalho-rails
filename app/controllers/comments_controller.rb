class CommentsController < ApplicationController

    def new

        @comment = Comment.new(name: cookies[:name])

    end


    def create
        @job = Job.find(params[:job_id])
        @comment = @job.comments.create(comment_params)
        @comment.save
        unless params[:name]
            cookies[:name] = @comment.name
        end
        flash[:notice] = "Comentário enviado!"
        redirect_to @job
    end

    def destroy
       @comment = Comment.find(params[:id])
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :name)
    end
end