class WikisController < ApplicationController
  include WikisHelper

  before_action :authenticate_user!

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    begin
      @wiki = Wiki.new(wiki_params)

      raise "not_authorized" if !authorize_wiki(@wiki)

      @wiki.user = current_user

      if @wiki.save
        redirect_to @wiki, notice: "Wiki was saved successfully."
      else
        flash.now[:alert] = "Error creating wiki. Please try again."
        render :new
      end
    rescue
      flash.now[:alert] = "You must be a premium member to create private wikis."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    begin
      @wiki = Wiki.find(params[:id])
      @wiki.assign_attributes(wiki_params)

      raise "not_authorized" if !authorize_wiki(@wiki)

      if @wiki.save
        flash[:notice] = "Wiki was updated."
        redirect_to @wiki
      else
        flash.now[:alert] = "Error saving wiki. Please try again."
        render :edit
      end
    rescue
      flash.now[:alert] = "You must be a premium member to change to a private wiki."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
