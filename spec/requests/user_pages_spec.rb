# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User Pages" do
  subject { page }
  describe "signup page" do
    before { visit signup_path }

    it { should have_content(I18n.t('signup')) }
    it { should have_title(full_title(I18n.t('signup'))) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { I18n.t('simple_form.labels.signup.submit') }
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(I18n.t('signup')) }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in I18n.t('simple_form.labels.signup.contactor'),              with: "李先生"
        fill_in I18n.t('simple_form.labels.signup.email'),                  with: "li@example.com"
        fill_in I18n.t('simple_form.labels.signup.password'),               with: "foobar"
        fill_in I18n.t('simple_form.labels.signup.password_confirmation'),  with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User,:count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
