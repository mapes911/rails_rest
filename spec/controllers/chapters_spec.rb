require 'spec_helper'
include SessionsHelper

describe ChaptersController do 

  let(:user) { FactoryGirl.create(:user) }
  let(:experience) { FactoryGirl.create(:experience, :user => user) }

  before do
    5.times do
      FactoryGirl.create(:chapter, :experience => experience) 
    end
  end

  describe '#create' do
    before { sign_in user }
    it 'while logged in returns 201 created' do
      post :create, :experience_id => experience.id, chapter: FactoryGirl.attributes_for(:chapter)
      response.code.should == '201'
    end

    it 'while not logged in returns 403 unauthorized' do
      sign_out
      post :create, :experience_id => experience.id, chapter: FactoryGirl.attributes_for(:chapter)
      response.code.should == '403'
    end   

    it 'while logged in with invalid input, returns unprocessable_entity' do
      post :create, :experience_id => experience.id
      response.code.should == '422'
    end   
  end

  describe '#update' do
    before { sign_in user }

    it 'while logged in returns 204' do
      put :update, :format => :json, :experience_id => experience.id, :id => 1, chapter: FactoryGirl.attributes_for(:chapter)
      response.code.should == '204'
    end

    it 'while logged in with invalid input, returns unprocessable_entity' do
      put :update, :format => :json, :experience_id => experience.id, :id => 1, chapter: {'title' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec egestas velit. Etiam velit nisi, placerat sit amet ornare nec, congue ac sapien. Nam euismod neque at neque euismod tincidunt. Proin posuere condimentum nulla, nec ornare neque consectetur vel. Fusce aliquet adipiscing lorem sit posuere.'}
      response.code.should == '422'
    end

    it 'while logged out returns 403' do
      sign_out
      put :update, :format => :json, :experience_id => experience.id, :id => 1, chapter: FactoryGirl.attributes_for(:chapter)
      response.code.should == '403'
    end

    it 'returns 404 for unknown chapter' do
      put :update, :format => :json, :experience_id => experience.id, :id => 10000, chapter: FactoryGirl.attributes_for(:chapter)
      response.should_not be_success
      response.code.should == '404'
    end    
  end

  describe '#destroy' do
    before { sign_in user }

    it 'while logged in returns 204' do
      delete :destroy, :format => :json, :experience_id => experience.id, :id => 1
      response.code.should == '204'
    end

    it 'while logged out returns 403' do
      sign_out
      delete :destroy, :format => :json, :experience_id => experience.id, :id => 1
      response.code.should == '403'
    end

    it 'returns 404 for unknown chapter' do
      delete :destroy, :format => :json, :experience_id => experience.id, :id => 10000, chapter: FactoryGirl.attributes_for(:chapter)
      response.should_not be_success
      response.code.should == '404'
    end    

  end
end