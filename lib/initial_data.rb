class InitialData

  def self.import_data
    sections  = [ :home, :about, :contact ]
    pages     = { 
                  :home     => [ 'Why us?', 'Because we rock!' ], 
                  :about    => [ 'Who are we?', 'A company that rocks!' ], 
                  :contact  => [ 'Contact us', 'Contact us.' ] 
                }
                
    user      = { 
                  :username => 'admin', 
                  :email    => 'webmaster@cloverinteractive.com', 
                  :pass     => 'admin' 
                }
    
    self.create_section_and_pages( sections, pages )
    self.create_admin( user )
    
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
      @section.pages.create!( :title => pages[section][0], :body => pages[section][1] )
    end
  end

end