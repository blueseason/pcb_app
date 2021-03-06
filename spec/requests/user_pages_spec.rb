# -*- coding: utf-8 -*-
require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

  end

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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before  do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content(I18n.t('edit_user')) }
      it { should have_title(I18n.t('edit_user')) }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in I18n.t('simple_form.labels.signup.contactor'),             with: new_name
        fill_in I18n.t('simple_form.labels.signup.email'),                 with: new_email
        fill_in I18n.t('simple_form.labels.signup.password'),              with: user.password
        fill_in I18n.t('simple_form.labels.signup.password_confirmation'), with: user.password
        fill_in I18n.t('simple_form.labels.signup.qq'),                    with: user.qq
        fill_in I18n.t('simple_form.labels.signup.mobile'),                with: user.mobile
        fill_in I18n.t('simple_form.labels.signup.address'),               with: user.address

        click_button I18n.t('simple_form.labels.update.submit')
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link(I18n.t('signout'), href: signout_path) }
      specify { expect(user.reload.real_name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "with invalid information" do

      before { click_button  I18n.t('simple_form.labels.update.submit') }

      it { should have_content('错误') }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
            password_confirmation: user.password } }
      end
      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
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
        it { should have_content('错误') }
      end
    end

    describe "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User,:count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'li@example.com') }

        it { should have_link(I18n.t('signout')) }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: I18n.t('signup_welcome')) }
      end

      describe "followed by signout" do
        before { click_link I18n.t('signout') }
        it { should have_link(I18n.t('signin')) }
      end
    end
  end
end
