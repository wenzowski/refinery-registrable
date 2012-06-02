Refinery::Core::Engine.routes.append do

  namespace :registrable do
    # root :to => "courses#index"
    # resources :courses,   :only => [:index, :show]

    devise_for :registrable_users,
      :class_name  => 'Refinery::Registrable::User',
      :controllers => {
        :registrations  => 'refinery/registrable/registrations',
        :sessions       => 'refinery/registrable/sessions'
      },
      :path_names  => {
        :sign_out => 'logout',
        :sign_in  => 'login',
        :sign_up  => 'register'
      }

  end

  namespace :registrable, :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'registrable' do
        # root :to => "courses#index"

        # resources :courses, :except => :show do
        #   collection do
        #     post :update_positions
        #   end
        # end

      end
    end
  end

end
