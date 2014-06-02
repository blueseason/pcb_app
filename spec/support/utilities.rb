# -*- coding: utf-8 -*-
include ApplicationHelper

def valid_signin(user)
  fill_in I18n.t('simple_form.labels.signin.email'),    with: user.email
  fill_in I18n.t('simple_form.labels.signin.password'), with: user.password
  click_button        I18n.t('signin')
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def full_title(page_title)
  base_title = I18n.t('company')
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in I18n.t('simple_form.labels.signin.email'),    with: user.email
    fill_in I18n.t('simple_form.labels.signin.password'), with: user.password
    click_button        I18n.t('signin')
  end
end
