class InitialData

  def self.import_data
    sections  = [ :hola, :conoce, :crece, :negocio, :contact ]
    pages     = {
                  :hola       => [  'Why us?',            'Because we rock!' ],
                  :conoce     => [  'Who are we?',        'A company that rocks!' ],
                  :crece      => [  'Uploading is dead',  'Try capistrano for a change.'],
                  :negocio    => [  'Happy Deploy',       'We are crazy about deploying apps.' ],
                  :contact    => [  'Contact us',         'Contact us.' ]
                }

    user      = {
                  :username => 'admin',
                  :email    => 'enrique@cloverinteractive.com',
                  :pass     => 'admin'
                }

    roles   = [ :post_editor, :post_comenter, :member ]
    rights  = {
                  :post_editor  =>  [
                                      {
                                        :name       => 'Create Post',
                                        :controller => 'posts',
                                        :action     => 'create'
                                      },
                                      {
                                        :name       => 'Render new Post form',
                                        :controller => 'posts',
                                        :action     => 'new'
                                      },
                                      {
                                        :name       => 'Delete Post',
                                        :controller => 'posts',
                                        :action     => 'destroy'
                                      }
                                    ],

                 :post_comenter =>  [
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
                                        :name       => 'Edit own first name',
                                        :controller => 'people',
                                        :action     => 'set_person_first_name'
                                      },
                
                                      {
                                        :name       => 'Edit own middle name',
                                        :controller => 'people',
                                        :action     => 'set_person_middle_name'
                                      },
                
                                      {
                                        :name       => 'Edit own last name',
                                        :controller => 'people',
                                        :action     => 'set_person_last_name'
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
    self.create_section_and_pages( sections, pages )
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
    @user.activation_date = Time.now
    @user.save!


    @user.admin = true
    @user.roles = []
    @user.save!
  end

  def self.create_section_and_pages( sections, pages )
    puts ">>>>> Creating demo Sections and Pages <<<<<"

    sections.each do |section|
      @section    = Section.create!( { :title => section.to_s.capitalize } )
      main_page   = pages[section][0] == "Why us?" 
      has_contact = pages[section][0] == "Contac us"
      @section.pages.create!( :title => pages[section][0], :body => pages[section][1], :main_page => main_page, :has_contact => has_contact)
    end
  end

end

