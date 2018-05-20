class CollaboratorsController < ApplicationController
  
  def create
    authorize Collaborator
    @user = User.find_by(email: params[:email])
    @wiki = Wiki.find(params[:wiki_id])
    if @user
      @collaborator = @wiki.collaborators.new(user_id: @user.id)
      if @collaborator.save
      else
        flash[:error] = "There was a problem adding user '#{@user.full_name}' as a contributor to this wiki."
      end
    else
      flash[:warning] = "User '#{params[:email]}' not found."
    end
    redirect_to :back
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    
    if @collaborator.destroy
      flash[:success] = "User '#{@collaborator.user.full_name}' is no longer a contributor to this wiki."
    else
      flash[:warning] = "There was a problem removing user '#{@collaborator.user.full_name}' as a contributor to this wiki."
    end
    redirect_to :back
  end
end
