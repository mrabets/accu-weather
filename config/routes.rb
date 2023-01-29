Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health', to: 'health#index'

      namespace :weather do
        get 'historical', to: 'historical#index'
        get 'historical/max'
        get 'historical/min'
        get 'historical/avg'
        get 'current'
        get 'by_time'
      end
    end
  end
end
