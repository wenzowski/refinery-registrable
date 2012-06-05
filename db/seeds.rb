::Refinery::Registrable.roles.each do |role|
  ::Refinery::Role[role]
end

::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinery_registrable').blank?
    user.plugins.create(:name => "refinery_registrable",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(::Refinery::User)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed
