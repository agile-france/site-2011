describe 'home' do
  it 'routes / to home/index' do
    {:get => '/'}.should route_to :controller => 'home', :action => 'index'
  end
end

describe 'sessions' do
  it 'should' do
    {:post => '/sessions'}.should route_to :controller => 'sessions', :action => 'create'
  end
end