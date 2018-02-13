class Wiki < ApplicationRecord
  belongs_to :user

  has_many :collaborators, dependent: :destroy

  validates :title, length: { minimum: 1 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true

  scope :visible_to, -> (user) {
    wikis = []
    if user.admin?
      # any
      wikis = Wiki.all
    elsif user.premium?
      all_wikis = Wiki.all
      all_wikis.each do |wiki|
        # public or mine or collaborator's
        if wiki.private? == false || wiki.user == user || wiki.collaborators.find { |wc| wc.user_id == user.id }
          wikis << wiki
        end
      end
    elsif user.standard?
      all_wikis = Wiki.all
      wikis = []
      all_wikis.each do |wiki|
        # public or collaborator's
        if wiki.private? == false || wiki.collaborators.find { |wc| wc.user_id == user.id }
          wikis << wiki
        end
      end
    end

    wikis
  }
end
