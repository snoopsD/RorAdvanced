class Question < ApplicationRecord
  has_many :answers, -> { order(best: :desc)}, dependent: :destroy
  has_many :attachments
  belongs_to :user

  validates :title, :body, presence: true, length: {minimum: 5}
end
