class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 1 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true

  scope :visible_to, -> (user) { user.admin? ? all : Wiki.where('wikis.user_id == ? OR wikis.private == ?', user.id, false) }
end
