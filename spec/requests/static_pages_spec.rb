# -*- coding: utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    subject { page }
    before { visit root_path }
    it { should have_title("青阳科技") }
  end
end
