class WikisController < ApplicationController
  include WikisHelper
  
  before_action :authenticate_user!, except: [:index, :show, :update]
  before_action :user_can_view_wiki, only: :show
  before_action :user_can_edit_wiki, only: [:edit, :update]
  
  def index
    @wikis = signed_in? ? Wiki.private_ones(current_user) : []
    @wikis += Wiki.public_ones
  end
  
  def show
  end

  def new
    @wiki = Wiki.new()
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    
    if @wiki.save
      flash[:notice] = { heading: "Success", message: "Wiki '#{@wiki.title}' created!" }
      redirect_to @wiki
    else
      flash.now[:alert] = { heading: "Error", message: "Failed to create wiki '#{@wiki.title}'. Please try again." }
      render :new
    end
  end

  def edit
  end
  
  def update
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = { heading: "Success", message: "Wiki '#{@wiki.title}' saved!" }
      redirect_to @wiki
    else
      flash.now[:alert] = { heading: "Error", message: "Failed to update wiki '#{@wiki.title}'. Please try again." }
      render :edit
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
  def user_can_view_wiki 
    @wiki = Wiki.find(params[:id])
    unless allowed_to_view_wiki(@wiki)
      flash[:alert] = { heading: "Access Denied",
                        message: "You do not have sufficient permissions to view that wiki." }
      redirect_to wikis_path
    end
  end
  
  def user_can_edit_wiki 
    @wiki = Wiki.find(params[:id])
    unless allowed_to_edit_wiki(@wiki)
      flash[:alert] = { heading: "Access Denied",
                        message: "You do not have sufficient permissions to edit that wiki." }
      redirect_to wikis_path
    end
  end
end
