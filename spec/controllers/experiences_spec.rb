require 'spec_helper'
include SessionsHelper

describe ExperiencesController do

  let(:user) { FactoryGirl.create(:user) }
  before do
    40.times do
      FactoryGirl.create(:experience, :user => user)
    end
  end

  describe '#index' do
    
    it 'returns a list of experiences' do
      get :index, :format => :json
      response.should be_success
      experiences = JSON.parse(response.body)
      experiences.length.should == 30
    end

    it 'should return a paginated response' do
      get :index, :format => :json, :page => 2
      response.should be_success
      experiences = JSON.parse(response.body)
      experiences.length.should == 10
    end

    it 'should return empty pages' do
      get :index, :format => :json, :page => 3
      response.should be_success
      experiences = JSON.parse(response.body)
      experiences.length.should == 0
    end

    it 'should 406 for html page - for now' do
      get :index
      response.code.should == '406'
    end

  end

  describe '#show' do

    it 'returns details of specific experience' do
      get :show, :format => :json, :id => 1
      response.should be_success
      experience = JSON.parse(response.body)
      experience['body'].should_not == ''
      experience['chapters'].should_not == ''
    end

    it 'returns 404 for unknown experience' do
      get :show, :format => :json, :id => 100000
      response.should_not be_success
      response.code.should == '404'
    end

    it 'should 406 for html page - for now' do
      get :index
      response.code.should == '406'
    end

  end

  # seems to be an issue with how to catch 404 in rails. leaving this for now.
  # describe '#new' do
  #   it 'returns 404' do
  #     get :new
  #     response.code.should == '404'
  #   end
  # end

  # describe '#edit' do
  # end

  describe '#create' do
    before { sign_in user }
    it 'while logged in returns 201 created' do
      post :create, experience: FactoryGirl.attributes_for(:experience)
      response.code.should == '201'
    end

    it 'while not logged in returns 403 unauthorized' do
      sign_out
      post :create, experience: FactoryGirl.attributes_for(:experience)
      response.code.should == '403'
    end   

    it 'while logged in with invalid input, returns unprocessable_entity' do
      post :create
      response.code.should == '422'
    end   
  end

  describe '#update' do
    before { sign_in user }

    it 'while logged in returns 204' do
      put :update, :format => :json, :id => 1, experience: FactoryGirl.attributes_for(:experience)
      response.code.should == '204'
    end

    it 'while logged in with invalid input, returns unprocessable_entity' do
      put :update, :format => :json, :id => 1, experience: {'title' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec egestas velit. Etiam velit nisi, placerat sit amet ornare nec, congue ac sapien. Nam euismod neque at neque euismod tincidunt. Proin posuere condimentum nulla, nec ornare neque consectetur vel. Fusce aliquet adipiscing lorem sit posuere.'}
      response.code.should == '422'
    end

    it 'while logged out returns 403' do
      sign_out
      put :update, :format => :json, :id => 1, experience: FactoryGirl.attributes_for(:experience)
      response.code.should == '403'
    end

    it 'returns 404 for unknown experience' do
      put :update, :format => :json, :id => 10000, experience: FactoryGirl.attributes_for(:experience)
      response.should_not be_success
      # why is this returning 403????
      response.code.should == '404'
    end    
  end

  describe '#destroy' do
    before { sign_in user }

    it 'while logged in returns 204' do
      delete :destroy, :format => :json, :id => 1
      response.code.should == '204'
    end

    it 'while logged out returns 403' do
      sign_out
      delete :destroy, :format => :json, :id => 1
      response.code.should == '403'
    end

    it 'returns 404 for unknown experience' do
      delete :destroy, :format => :json, :id => 10000, experience: FactoryGirl.attributes_for(:experience)
      response.should_not be_success
      # why is this returning 403????
      response.code.should == '404'
    end    

  end

end




