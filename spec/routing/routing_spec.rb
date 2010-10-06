describe 'home' do
  it 'routes / to home/index' do
    {:get => '/'}.should route_to :controller => 'home', :action => 'index'
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
end

