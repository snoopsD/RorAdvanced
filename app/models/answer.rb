class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: {minimum: 5}

  def check_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
