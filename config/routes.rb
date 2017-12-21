Rails.application.routes.draw do
  devise_for :users
 
  concern :votable do
    member do
      post :voteup
      post :votedown
    end
  end

  resources :questions, concerns: [:votable] do
    resources :answers, concerns: [:votable], shallow: true do
      patch :best_answer, on: :member
    end
  end  

  root to: "questions#index"  

  mount ActionCable.server => '/cable'
end
