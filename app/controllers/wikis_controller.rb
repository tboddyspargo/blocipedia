class WikisController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_wiki_ownership, only: [:show, :edit]
  
  def index
    @wikis = Wiki.public_ones
  end
  
  def show
  end

  def new
    @wiki = Wiki.new()
  end

  def edit
  end
  
  private
  def check_wiki_ownership 
    @wiki = Wiki.find(params[:id])
    if @wiki.private && current_user != @wiki.user
      flash[:error] = { heading: "Access Denied",
                        message: "You do not have sufficient permissions to view that wiki." }
      redirect_to wikis_path
    end
  end
end
