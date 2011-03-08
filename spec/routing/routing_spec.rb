describe 'home' do
  it 'routes / to conferences/index' do
    {:get => '/'}.should route_to :controller => 'conferences', :action => 'recent'
  end
end

describe 'conferences' do
  it 'routes GET /conferences/1' do
    {:get => '/conferences/1'}.should route_to :controller => 'conferences',
    :action => 'show', :id => "1"
  end

  describe 'nests session creation' do
    # XXX rails do not generate reversible nested resources path
    it 'should recognize a nested session POST' do
      assert_recognizes({:controller => 'sessions', :action => 'create', :conference_id => '1'},
        {:path => '/conferences/1/sessions', :method => :post})
    end
  end
  
  describe 'nests registration creation' do
    # XXX rails do not generate reversible nested resources path
    it 'should recognize a nested registration POST' do
      assert_recognizes({:controller => 'registrations', :action => 'create', :conference_id => '1'},
        {:path => '/conferences/1/registrations', :method => :post})
    end
  end
end

describe "admin section" do
  it "should GET /admin" do
    {:get => '/admin'}.should route_to :controller => 'admin/admin', :action => 'show'
  end
  describe 'nested user admin' do
    # XXX rails do not generate reversible nested resources path
    it 'should recognize a nested user PUT' do
      assert_recognizes({:controller => 'admin/users', :action => 'update', :id => '1'},
        {:path => '/admin/users/1', :method => :put})
    end
    it 'should recognize a nested user EDIT form' do
      assert_recognizes({:controller => 'admin/users', :action => 'edit', :id => '1'},
        {:path => '/admin/users/1/edit', :method => :get})
    end
  end  
end

describe 'sessions' do
  it 'routes GET /sessions/1' do
    {:get => '/sessions/1'}.should route_to :controller => 'sessions',
    :action => 'show', :id => "1"      
  end
  it 'routes GET /sessions/1/edit' do
    {:get => '/sessions/1/edit'}.should route_to :controller => 'sessions',
    :action => 'edit', :id => "1" 
  end
  it 'routes PUT /sessions/1' do
    {:put => '/sessions/1'}.should route_to :controller => 'sessions',
    :action => 'update', :id => "1"      
  end
  
  describe 'nests rating creation' do
    # XXX rails do not generate reversible nested resources path
    it 'should recognize a nested rating POST' do
      assert_recognizes({:controller => 'ratings', :action => 'create', :awesome_session_id => '1'},
        {:path => '/sessions/1/ratings', :method => :post})
    end
  end  
end

describe 'account' do
  it 'routes GET /account/edit' do
    {:get => '/account/edit'}.should route_to :controller => 'account', :action => 'edit'
  end
  it 'routes PUT /account' do
    {:put => '/account'}.should route_to :controller => 'account', :action => 'update'
  end
  it 'routes DELETE /account' do
    {:delete => '/account'}.should route_to :controller => 'account', :action => 'destroy'
  end
  it 'routes GET /account/sessions' do
    {:get => '/account/sessions'}.should route_to :controller => 'account', :action => 'sessions'
  end
end

describe "company" do
  it "routes GET /company" do
    {:get => '/companies'}.should route_to :controller => 'companies', :action => 'index'
  end
end