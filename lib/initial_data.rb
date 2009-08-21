class InitialData

  def self.import_data
    sections  = [ :home, :about, :contact ]
    pages     = { 
                  :home     => [ 'why_us',      'Why us?',      'Because we rock!' ], 
                  :about    => [ 'who_are_we',  'Who are we?',  'A company that rocks!' ], 
                  :contact  => [ 'contact_us',  'Contact us',   'Contact us.' ] 
                }
                
    user      = { 
                  :username => 'admin', 
                  :email    => 'webmaster@cloverinteractive.com', 
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
                                        :name       => 'Edit own Profile',
                                        :controller => 'users',
                                        :action     => 'profile'
                                      }
                                    ]
              }
    
    self.create_section_and_pages( sections, pages )
    self.create_roles_and_rights( roles, rights )
    self.create_admin( user )
  
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
    
    @person       = @user.person
    @person.type  = 'Admin'
    @person.save!
  end
  
  def self.create_section_and_pages( sections, pages )
    puts ">>>>> Creating demo Sections and Pages <<<<<"
    
    sections.each do |section| 
      @section = Section.create!( { :name => section.to_s.capitalize } ) 
      @section.pages.create!( :name => pages[section][0], :title => pages[section][1], :body => pages[section][2] )
    end
  end

end