require 'spec_helper'

describe Chapter do

  let(:experience) { FactoryGirl.create(:experience) }

  before { @chapter = experience.chapters.build(title: "First I found a boat", body: "The boat was so small. I liked it very much") }

  subject { @chapter }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:experience_id) }
  it { should respond_to("experience") }
  its (:experience) { should == experience }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to experience_id" do
      expect do
        Chapter.new(experience_id: experience.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when experience_id is not present" do
    before { @chapter.experience_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @chapter.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @chapter.title = "a" * 301 }
    it { should_not be_valid }
  end

  describe "with blank body" do
    before { @chapter.body = " " }
    it { should_not be_valid }
  end

end