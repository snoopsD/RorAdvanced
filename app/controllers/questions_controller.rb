class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show    
    @answer = @question.answers.new
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question succefully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)      
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if current_user.owner?(@question)
      @question.destroy
      flash[:notice] = 'Your question succefully deleted.'
      redirect_to questions_path
    else
      redirect_to @question, notice: 'You are not the author question.'
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end
