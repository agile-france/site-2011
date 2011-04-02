#encoding: utf-8
require 'spec_helper'

describe CompaniesController do
  context "mere user" do
    touch_db_with(:awesome) {Fabricate(:company)}
    touch_db_with(:google) {Fabricate(:company, :name => 'google')}
    touch_db_with(:john) {Fabricate(:user, :company => awesome)}
    before do
      sign_in(john)
    end
    describe "requires to be admin to delete" do
      it 'should redirect on delete' do
        post :destroy, :id => awesome.id
        response.should redirect_to root_path
      end
    end
    it 'can update company name' do
      put :update, :id => awesome.id, :company => {:name => 'zoo'}
      assert {flash[:notice] =~ /mise à jour/}
      assert {Company.find(awesome.id).name == 'zoo'}
    end
    it 'cannot update another name' do
      put :update, :id => google.id, :company => {:name => 'ZOO'}
      assert {flash[:error] =~ /pas autorisé/i}
      deny {Company.find(google.id).name == 'ZOO'}
    end
    
    describe "create" do
      # POST database fixture are a pain to handle
      # POST once and destroy
      it 'actually creates a company for self, and inform user of its roles in company' do
        post :create, :company => {:name => 'FOO'}
        john.reload
                
        assert {john.company.name == 'FOO'}
        assert {flash[:notice] =~ /(john.*), vous faites maintenant parti de FOO/i}
      end
    end
    after(:all) {Company.destroy_all}
  end
  
  context "admin logged in" do
    touch_db_with(:user) {Fabricate(:user, :admin => true)}
    touch_db_with(:awesome) {Fabricate(:company, :name => 'awesome')}
    before do
      sign_in(user)
      post :destroy, :id => awesome.id
    end
    describe "requires to be admin to delete" do
      it 'should redirect to list of company' do
        response.should redirect_to companies_path
      end
      it 'kills it' do
        assert {Company.criteria.for_ids(awesome.id).empty?}
      end
    end
  end
  
  describe "update a company" do
    touch_db_with(:awesome) {Fabricate(:company, :name => 'awesome')}
    it "show a nice form" do
      get :edit, :id => awesome.id
      response.should be_success
    end
  end
  
  describe "list company" do
    render_views
    it "returns list of company" do
      get :index
      response.should be_success
    end
  end
  
  describe "list company as json" do
    ['awesome', 'haskell'].each { |name| touch_db_with(name.to_sym) {Fabricate(:company, :name => name)} }
    before do
      get :index, :format => 'json'
    end
    it "return list of company" do
      response.should be_success
      cies = Yajl::Parser.parse(response.body)
      assert {cies.map {|cie| cie['name']} == ['awesome', 'haskell']}
    end
  end
end