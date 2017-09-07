require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user)     { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer)   { create(:answer, question: question, user: user) }


  describe 'POST #create' do
    sign_in_user

    context 'with valide attributes' do
      it 'save new answer in database with user' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end

      it 'save new answer in database with question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js }
        expect(subject).to render_template :create
      end
    end
  end

  describe 'DELETE#destroy' do
    sign_in_user

    before { answer }

    context 'Author answer' do
      let!(:answer) { create(:answer, question: question, user: @user) }

      it 'delete answer' do
        expect { delete :destroy, params: { question_id: question, id: answer }, format: :js }.to change(Answer, :count).by(-1)
      end

      it "render template delete" do
        delete :destroy, params: { question_id: question, id: answer, format: :js }
        expect(response).to render_template :destroy
      end
    end

    context 'NotAuthor answer' do

      it 'delete answer' do
        expect { delete :destroy, params: { question_id: question, id: answer }, format: :js }.not_to change(Answer, :count)
      end

      it 'render template delete' do
        delete :destroy, params: { question_id: question, id: answer}, format: :js 
        expect(response).to render_template :destroy
      end
    end
  end

end
