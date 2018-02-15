class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def create
    ids = params[:id]
    if !ids.empty?
      u_id, w_id, ind = ids[0].split("/")
      wiki = Wiki.where(id: w_id)
      if !wiki.empty?
        if !wiki[0].private || ind == "delete"
          # make sure public wiki doesn't have Collaborators
          Collaborator.where('wiki_id == ?', w_id).destroy_all
        else
          curr = Collaborator.where('wiki_id == ?', w_id).pluck(:user_id)
          ids.each do |i|
            u_id, w_id = i.split("/")
            if curr.include?(u_id.to_i)
              curr.delete(u_id.to_i)      # only deletions shall remain
            else
              Collaborator.new(user_id: u_id, wiki_id: w_id).save
            end
          end
          curr.each do |u_id|
            Collaborator.where('user_id == ? AND wiki_id == ?', u_id, w_id).destroy_all
          end
        end
      end
    end

    head :no_content
  end
end
