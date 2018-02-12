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

      params.permit(:refresh)
      if params[:refresh]
        @latest_markdown = markdown(params[:wiki][:body])
        render :new
        return
      end

      raise "not_authorized" if !authorize_wiki(@wiki)

      @wiki.user = current_user

      if @wiki.save
        redirect_to @wiki, notice: "Wiki was saved successfully."
      else
        flash.now[:alert] = "Error creating wiki. Please try again."
        render :new
      end
    rescue
      flash.now[:alert] = "You must be a premium member to create private wikis. Try upgrading your account!"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @latest_markdown = markdown(@wiki.body)
  end

  def update
    begin
      @wiki = Wiki.find(params[:id])
      @wiki.assign_attributes(wiki_params)

      params.permit(:refresh)
      if params[:refresh]
        @latest_markdown = markdown(params[:wiki][:body])
        render :edit
        return
      end

      raise "not_authorized" if !authorize_wiki(@wiki)

      if @wiki.save
        flash[:notice] = "Wiki was updated."
        redirect_to @wiki
      else
        flash.now[:alert] = "Error saving wiki. Please try again."
        render :edit
      end
    rescue
      flash.now[:alert] = "You must be a premium member to change to a private wiki. Try upgrading your account!"
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
