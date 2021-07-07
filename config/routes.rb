Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] 
  resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
  # ——————————————— ここから ———————————————
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  # ——————————— ここまでネストさせる ———————————
  # relationships は中間テーブルなので、usersモデルにネストさせます。
  # followingsとfollowersは一覧ページ用に定義したアクション
  end
end