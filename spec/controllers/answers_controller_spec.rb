require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user)     { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer)   { create(:answer, question: question, user: user) }


  describe 'POST #create' do
    sign_in_user

    context 'with valide attributes' do
      it 'save new answer in database with user' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(@user.answers, :count).by(1)
      end

      it 'redirect to view question with answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with valide attributes' do
      it 'save new answer in database with question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(Answer.where(question: question), :count).by(1)
      end

      it 'redirect to view question with answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end


    context 'with invalid attributes' do
      it 'does not save answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(subject).to render_template("questions/show")
      end
    end
  end

  describe 'DELETE#destroy' do
    sign_in_user

    before { answer }

    context 'Author answer' do
      let!(:answer) { create(:answer, question: question, user: @user) }

      it 'delete answer' do
        expect { delete :destroy, params: { question_id: question, id: answer } }.to change(Answer, :count).by(-1)
      end

      it "render template delete" do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'NotAuthor answer' do

      it 'delete answer' do
        expect { delete :destroy, params: { question_id: question, id: answer } }.not_to change(Answer, :count)
      end

      it 'render template delete' do
        delete :destroy, params: { question_id: question, id: answer }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end

end
