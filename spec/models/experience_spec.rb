require 'spec_helper'

describe Experience do

  let(:user) { FactoryGirl.create(:user) }
  before { @experience = user.experiences.build(
    title: "I sailed across the Atlantic in a small craft",
    moral: "I learned so much about who I am"
  ) }

  subject { @experience }

  it { should respond_to(:title) }
  it { should respond_to(:moral) }
  it { should respond_to(:user_id) }
  it { should respond_to("user") }
  its (:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Experience.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @experience.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @experience.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @experience.title = "a" * 301 }
    it { should_not be_valid }
  end

  describe "with blank moral" do
    before { @experience.moral = " " }
    it { should_not be_valid }
  end

  describe "with moral that is too long" do
    before { @experience.moral = "a" * 301 }
    it { should_not be_valid }
  end

end