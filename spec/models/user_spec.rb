# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do

  before { @user = User.new(name: "王先生", email: "wang@example.com", mobile: "13818008888") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:mobile) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "网" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end
end
