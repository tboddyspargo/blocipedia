# frozen_string_literal: true

class CollaboratorsController < ApplicationController
  def create
    authorize Collaborator
    @user = User.find_by(email: params[:email])
    @wiki = Wiki.find(params[:wiki_id])
    if @user
      @collaborator = @wiki.collaborators.new(user_id: @user.id)
      if @collaborator.save
        flash[:notice] = "Successfully added user '#{helpers.user_name(@user)}' as a collaborator to this wiki."
      else
        flash[:error] = "There was a problem adding user '#{helpers.user_name(@user)}' as a contributor to this wiki."
      end
    else
      flash[:warning] = "User '#{params[:email]}' not found."
    end
    redirect_back(fallback_location: @wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:success] = "User '#{helpers.user_name(@collaborator.user)}' is no longer a contributor to this wiki."
    else
      flash[:warning] =
        "There was a problem removing user '#{helpers.user_name(@collaborator.user)}' as a contributor to this wiki."
    end
    redirect_back(fallback_location: @wiki)
  end
end
