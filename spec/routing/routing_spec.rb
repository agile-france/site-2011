describe 'home' do
  it 'routes / to home/index' do
    {:get => '/'}.should route_to :controller => 'home', :action => 'index'
  end
end

describe 'conferences' do
  before do
    @cheesy = Factory(:conference)
  end
  it 'routes GET :id' do
    {:get => '/conferences/1'}.should route_to :controller => 'conferences',
                                               :action => 'show', :id => "1"
  end

  describe 'with nested sessions' do
    # XXX rails do not generate reversible nested resources path
    it 'should recognize a nested session POST' do
      assert_recognizes({:controller => 'sessions', :action => 'create', :conference_id => '1'},
                        {:path => '/conferences/1/sessions', :method => :post})
    end

    it 'recognize PUT /conferences/12/sessions/23 as update of session' do
      assert_recognizes({:controller => 'sessions', :action => 'update', :conference_id => '12', :id => '23'},
                        {:path => '/conferences/12/sessions/23', :method => :put})
    end
  end
end

