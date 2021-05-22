Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'about' => 'pages#about'
  get 'about/author' => 'pages#about_author'
end
