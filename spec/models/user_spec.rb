# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "Наличие name" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "Наличие email" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "Валидация длины name" do
    before { @user.name = "a" * 31 }
    it { should_not be_valid }
    before { @user.name = "a" * 5 }
    it { should_not be_valid }
  end

  describe "Неправильный формат email" do
    it "должно быть false" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "Правильный формат email" do
    it "должно быть true" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "Проверка уникальности email" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "Пароль не может быть пустым" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "Пароль не проходит подтверждение" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "Подтверждение пароля = nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "Пароль слишком короткий" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "Возвращает значение медота авторизации" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "правильный пароль" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "не правильный пароль" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
