class InitialData

  def self.import_data
    content_fixture = File.new(Dir.pwd + '/lib/pages/pages_fixtures.yml')
    data            = YAML::load(content_fixture)

    user      = { :username => 'enrique', :email    => 'enrique@cloverinteractive.com', :password => 'administrator' }

    roles     = [ :post_editor, :post_commenter, :member, :snippet_creator ]
    rights    = {
                    :post_editor  =>  [
                                        {
                                          :name       => 'Post list',
                                          :controller => 'articles',
                                          :action     => 'index'
                                        },
                                        {
                                          :name       => 'Create Post',
                                          :controller => 'articles',
                                          :action     => 'create'
                                        },
                                        {
                                          :name       => 'Render new Post form',
                                          :controller => 'articles',
                                          :action     => 'new'
                                        },
                                        {
                                          :name       => 'Render edit Post',
                                          :controller => 'articles',
                                          :action     => 'edit'
                                        },
                                        {
                                          :name       => 'Update Post',
                                          :controller => 'articles',
                                          :action     => 'update'
                                        },
                                        {
                                          :name       => 'Delete Post',
                                          :controller => 'articles',
                                          :action     => 'destroy'
                                        }
                                      ],

                   :post_commenter =>  [
                                        {
                                          :name       => 'Create Comment',
                                          :controller => 'comments',
                                          :action     => 'create'
                                        }
                                      ],

                  :member         =>  [
                                        {
                                          :name       => 'View own Profile',
                                          :controller => 'users',
                                          :action     => 'profile'
                                        },

                                        {
                                          :name       => 'Edit avatar, gender and date of birth',
                                          :controller => 'people',
                                          :action     => 'update'
                                        },

                                        {
                                          :name       => 'View other users profile',
                                          :controller => 'users',
                                          :action     => 'show'
                                        }
                                      ],
                
                :snippet_creator  => [
                                        {
                                          :name       => 'Create Snippet',
                                          :controller => 'snippets',
                                          :action     => 'create'
                                        },
                                        
                                        {
                                          :name       => 'Render new Snippet',
                                          :controller => 'snippets',
                                          :action     => 'new'
                                        },
                                        
                                        {
                                          :name       => 'Update Snippet',
                                          :controller => 'snippets',
                                          :action     => 'update'
                                        },
                                        
                                        {
                                          :name       => 'Render edit Snippet',
                                          :controller => 'snippets',
                                          :action     => 'edit'
                                        },
                                        
                                        {
                                          :name       => 'Delete Snippet',
                                          :controller => 'snippets',
                                          :action     => 'destroy'
                                        },
                                        
                                        {
                                          :name       => 'List snippets',
                                          :controller => 'snippets',
                                          :action     => 'index'
                                        }
                                      ]
                }

    meta_tags = [
                  "Best Website Ever.",
                  "Fast Web development.",
                  "Smart Solutions.",
                  "Cool Design.",
                  "Great affordable services.",
                  "Super Solutions."
                ]

    self.create_meta_tags( meta_tags )
    self.create_section_and_pages( data )
    self.assign_meta_tags
    self.create_roles_and_rights( roles, rights )
    self.create_admin( user )

  end

  def self.create_meta_tags( meta_tags )
    puts ">>>>>> Creating MetaTags <<<<<"
    meta_tags.each { |meta| MetaTag.create!( :content => meta ) }
  end

  def self.assign_meta_tags
    puts ">>>>>> Assigning MetaTags <<<<<<"
    1.upto(3) do |position|
      page = Page.find( position )
      page.meta_title_id        = position
      page.meta_description_id  = ( position + 3 )
      page.save!
    end
  end

  def self.create_roles_and_rights( roles, rights )
    puts ">>>>> Creating Roles and Rights <<<<<"

    roles.each do |role|
      @role = Role.create!( { :name => role.to_s.capitalize.gsub( /_/, ' ' ) } )
      rights[role].each { |right| @role.rights.create!(right) }
    end
  end

  def self.create_admin( user )
    puts ">>>>> Creating Admin User <<<<<"

    @user                 = User.create!( user )
    @user.save!
    @user.confirmed_at    = Time.now

    @user.admin = true
    @user.roles = []
    @user.save!
  end

  def self.create_section_and_pages( data )
    puts ">>>>> Creating demo Sections and Pages <<<<<"

    data.flatten.each do |page|
      if page.class == String
        @section = Section.find_or_create_by_title(page)
        @section.save!
      else
        @page = @section.pages.build( :title => page["title"], :body => page["body"] )

        if @page.valid?
          @page.save!         
          @page.update_attributes!(:main_page   => true) if @page.id == 1
          # This line adds a contact form to a page, but will remain commented until the contact form for this project is defined
          #@page.update_attributes!(:has_contact => true) if @page.section.name== "contacto"
        end
      end
    end

  end

end

