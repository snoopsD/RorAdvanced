class Question < ApplicationRecord
  include Votable

  belongs_to :user
  has_many :answers, -> { order(best: :desc)}, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable  

  validates :title, :body, presence: true, length: {minimum: 5}  
  
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
