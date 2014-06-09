# -*- coding: utf-8 -*-
class Order < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true

  validates :length, presence: true, numericality: { greater_than: 0.0 }
  validates :width, presence: true, numericality: { greater_than: 0.0 }
  validates :layer, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { only_integer: true }
  validates :pinban_style_num, presence: true, numericality: { only_integer: true }
  validates :thickness, presence: true, numericality: { greater_than_or_equal_to: 0.4,
                                                        less_than_or_equal_to: 2.0 }
  validates :zuhan_color, presence: true, numericality: { only_integer: true }
  validates :zifu_color, presence: true, numericality: { only_integer: true }
  validates :hanpan_pengdu, presence: true, numericality: { only_integer: true }
  validates :zuhan_cover, presence: true, numericality: { only_integer: true }
  validates :test, presence: true, numericality: { only_integer: true }
  validates :tongbo_thickness, presence: true, numericality: { only_integer: true }
  validates :produce_time, presence: true, numericality: { only_integer: true }
  validates :need_receipt, presence: true, numericality: { only_integer: true }
  validates :express, presence: true, numericality: { only_integer: true }

  private

  def calc_price
    self.express_pay = 0.0
    self.net_pay = 0.0
    self.area = length * width * amount
  end
end
