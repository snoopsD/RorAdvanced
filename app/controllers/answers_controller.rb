class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_question, only: [:new, :create, :destroy]
  before_action :set_answer, only: [:destroy]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Your answer created'
    else
      flash[:notice] = 'Your answer not created'
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
    params.require(:answer).permit(:body)
  end

end
