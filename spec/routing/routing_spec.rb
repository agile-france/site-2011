describe 'home' do
  it 'routes / to home/index' do
    {:get => '/'}.should route_to :controller => 'home', :action => 'index'
  end
end

describe 'conferences' do
it 'routes GET :name/:edition' do
   {:get => '/conferences/agile-france/2011'}.should route_to :controller => 'party/conferences',
                                      :action => 'show', :name => 'agile-france', :edition => '2011'
end
end

describe 'sessions' do
  it 'should' do
    {:post => '/party/sessions'}.should route_to :controller => 'party/sessions', :action => 'create'
  end
end