::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'refinerycms_registrable').blank?
    user.plugins.create(:name => "refinerycms_registrable",
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(::Refinery::User)


if defined?(::Refinery::Page) and !::Refinery::Page.exists?(:link_url => '/registrable')

  # registrable_page = ::Refinery::Page.create(
  #   :title      => 'Registrable',
  #   :link_url   => '/registrable',
  #   :deletable  => false,
  #   :menu_match => '^/registrables?(\/|\/.+?|)$'
  # )
  # Refinery::Pages.default_parts.each do |default_page_part|
  #   registrable_page.parts.create(:title => default_page_part, :body => nil)
  # end

end

::Refinery::Registrable::Role.all.each do |role|
  ::Refinery::Role.create! do |m|
    m.title = role
  end unless ::Refinery::Role.exists?(:title => role)
end if defined?(::Refinery::Role)
