describe 'home' do
  it 'routes / to home/index' do
    {:get => '/'}.should route_to :controller => 'home', :action => 'index'
  end
end

describe 'sessions' do
  it 'should' do
    {:post => '/conference/sessions'}.should route_to :controller => 'conference/sessions', :action => 'create'
  end
end