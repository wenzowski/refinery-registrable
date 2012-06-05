Refinery::Core::Engine.routes.draw do

  namespace :registrable, :path => '' do
    resources :registrations, :except => :index
  end

  namespace :registrable do
    resources :example_authentications, :only => :index do
      collection do
        get 'register_or_login'
        get 'user_dashboard'
      end
    end
  end

  namespace :registrable, :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'registrable' do
        root :to => "user_fields#index"

        resources :user_fields do
          collection do
            resources :texts, :controller => 'user_fields'
          end
        end
        # scope :path => 'user_fields' do
        #
        # end

        resources :settings do
          collection do
            get :registrable
          end
        end

      end
    end
  end

end
