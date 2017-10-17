class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, presence: true, length: {minimum: 5}

  accepts_nested_attributes_for :attachments

  def check_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
