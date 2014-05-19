# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User Pages" do
  subject { page }
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('注册') }
    it { should have_title(full_title('注册')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "立即注册" }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "联系人",          with: "李先生"
        fill_in "邮箱地址",        with: "li@example.com"
        fill_in "密码",            with: "foobar"
        fill_in "确认密码",        with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User,:count).by(1)
      end
    end
  end
end
