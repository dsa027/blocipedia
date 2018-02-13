class WikisController < ApplicationController
  include WikisHelper

  before_action :authenticate_user!

  def index
    @wikis = Wiki.visible_to(current_user)
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

      update_collabs(params)

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

      update_collabs(params)

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

  def update_collabs(c)
    if !@wiki.private
      # make sure public wiki doesn't have Collaborators
      Collaborator.where('wiki_id == ?', @wiki).destroy_all
    else
      # delete collabs that were collabs and no longer are
      # add collabs that weren't collabs and now are
      add, del = [], []
      # get all checkboxes
      c.select { |k,v| k.start_with?("checkbox:") }.each { |k,v| v == '1' ? add << get_user_id(k) : del << get_user_id(k) }
      # delete those that aren't checked
      del.each { |k| Collaborator.where('user_id == ? AND wiki_id == ?', k, @wiki).destroy_all }
      # add those that are checked
      add.each do |k|
        adds = Collaborator.where('user_id == ? AND wiki_id == ?', k, @wiki)
        if adds.empty?
          Collaborator.new(user_id: k, wiki: @wiki).save
        end
      end
    end
  end

  def get_user_id(str)
    str.sub("checkbox:", "")
  end
end
