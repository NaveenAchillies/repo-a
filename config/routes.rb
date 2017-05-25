Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'ledgers#index'
  get 'index' => 'ledgers#index'

  resources :ledgers do
  	get :new_income, :on => :member
  	get :new_expense, :on => :member
  end
  
  devise_for :users, :controllers => {:sessions => 'sessions',:registrations => 'registrations'}
  
end
