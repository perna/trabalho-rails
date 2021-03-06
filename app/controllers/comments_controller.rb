class CommentsController < ApplicationController

    def new
	unless params[:name]
           @comment = Comment.new(name: cookies[:name])
	end
    end

    def create
        @job = Job.find(params[:job_id])
        @comment = @job.comments.create(comment_params)
        if @comment.save
        	unless params[:name]
            	cookies[:name] = @comment.name
        	end
        	flash[:notice] = "Comentário enviado!"
	else
		flash[:alert] = "Erro ao enviar Comentario" 
	end       
	redirect_to @job
    end

    def destroy
       
      @comment = Comment.find(params[:id])
      if cookies[:name] == @comment.name	
	@comment.destroy
	redirect_to @comment.job, notice: "Comentario excluido com sucesso"
      else
	redirect_to @comment.job, alert: "Impossivel Deletar post de outra Pessoa"
      end	
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :name)
    end
end
