# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "Отсутствует юзер айди" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "пустой контент" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "слишком длинный контент" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
