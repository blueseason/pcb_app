# -*- coding: utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    base_title = I18n.t('company')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  X = Struct.new(:id, :name)

  def express
    express =[['广东省内', [X.new(1,'联昊通或速尔快递免邮费'), X.new(2,'顺丰到付'), X.new(3,'其他快递到付')]],
              ['广东省外', [X.new(3,'顺丰到付'), X.new(4,'其他快递到付')]]]
  end

end
