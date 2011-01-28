#encoding: utf-8
require 'spec_helper'

describe CompaniesController do
  context "mere user" do
    let(:awesome) {Fabricate(:company)}
    let(:john) {Fabricate(:user, :company => awesome)}
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
      zoo = Fabricate(:company, :name => 'zoo')
      put :update, :id => zoo.id, :company => {:name => 'ZOO'}
      assert {flash[:error] =~ /pas autorisé/i}
      deny {Company.find(awesome.id).name == 'ZOO'}
    end
    
    describe "create" do
      before do
        post :create, :company => {:name => 'ZOO'}
        john.reload
      end
      it 'actually creates a company for self' do
        assert {john.company.name == 'ZOO'}
      end
      it 'inform user of its roles in company' do
        assert {flash[:notice] =~ /(john.*), vous faites maintenant parti de ZOO/i}
      end
    end
  end
  
  context "admin logged in" do
    let(:user) {Fabricate(:user, :admin => true)}
    let(:awesome) {Fabricate(:company, :name => 'awesome')}
    before do
      sign_in(user)
      post :destroy, :id => awesome.id
    end
    describe "requires to be admin to delete" do
      it 'should redirect to list of company' do
        response.should redirect_to companies_path
      end
      it 'kills it' do
        deny {Company.criteria.id(awesome.id).first}
      end
    end
  end
  
  describe "update a company" do
    let(:awesome) {Fabricate(:company, :name => 'awesome')}
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
    before do
      @awesome = Fabricate(:company, :name => 'awesome')
      @haskell = Fabricate(:company, :name => 'haskell')
      get :index, :format => 'json'
    end
    it "return list of company" do
      response.should be_success
      cies = Yajl::Parser.parse(response.body)
      assert {cies.map {|cie| cie['name']} == ['awesome', 'haskell']}
    end
  end
end