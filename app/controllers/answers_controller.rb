class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :destroy, :update]
  before_action :set_answer, only: [:update, :destroy, :best_answer]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Your answer created'
    else
      flash[:notice] = 'Your answer not created'
    end
  end

  def best_answer
    @answer.check_best if current_user.owner?(@answer.question)
  end

  def update
    if current_user.owner?(@answer)
      @answer.update(answer_params)
      flash.now[:notice] = 'Your answer updated'
    else
      flash.now[:notice] = 'Your answer was not updated'
    end
  end

  def destroy
    if current_user.owner?(@answer)
      @answer.destroy
      flash[:notice] =  'Your answer deleted.'
      redirect_to question_path(@question)
    else
      redirect_to question_path(@question), notice: 'You are not author.'
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

end
