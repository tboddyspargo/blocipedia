class WikisController < ApplicationController
  include ApplicationHelper
  include WikisHelper
  
  before_action :authenticate_user!, except: [:index, :show]
  
  after_action :verify_authorized, except: [:index, :preview]
  after_action :verify_policy_scoped, only: :index
  
  def index
    @wikis = policy_scope(Wiki.search({ title: params[:search] })).paginate(page: params[:page], per_page: 20)
  end
  
  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new()
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    @wiki.owner = current_user
    
    if @wiki.save
      flash[:notice] = { heading: "Success", message: "#{@wiki.title} created!" }
      redirect_to @wiki
    else
      flash.now[:alert] = { heading: "Error", message: "Failed to create #{@wiki.title}. Please try again.", errors: @wiki.errors }
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def preview
    render html: markdown("#{params[:content]}"), layout: false
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = { heading: "Success", message: "<i>#{@wiki.title}</i> saved!" }
      redirect_to @wiki
    else
      flash.now[:alert] = { heading: "Error", message: "Failed to update wiki <i>'#{@wiki.title}'</i>. Please try again.", errors: @wiki.errors }
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = { heading: "Success", message: "<i>#{@wiki.title}</i> has been deleted!" }
      redirect_to wikis_path
    else
      flash.now[:alert] = { heading: "Error", message: "Unable to delete <i>#{@wiki.title}</i>.", errors: @wiki.errors }
      render :edit
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
