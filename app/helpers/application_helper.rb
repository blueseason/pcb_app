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

  PCB_JSON = JSON.parse(File.read("#{Rails.root}/db/pcb.json"))
  ZH_COLORS = PCB_JSON["zh_color"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  ZF_COLORS = PCB_JSON["zf_color"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  HP_PENGDU = PCB_JSON["hp_pengdu"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  ZH_COVER = PCB_JSON["zh_cover"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  TEST = PCB_JSON["test"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  TB_THICKNESS = PCB_JSON["tb_thickness"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  P_TIME = PCB_JSON["p_time"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a
  RECEIPT = PCB_JSON["receipt"].each_with_object({}) {|(k,v),new_hash| new_hash[v] =k }.to_a

  def hanpan_pengdu
    HP_PENGDU
  end

  def zuhan_cover
    ZH_COVER
  end

  def test
    TEST
  end

  def tongbo_thickness
    TB_THICKNESS
  end

  def produce_time
    P_TIME
  end

  def need_receipt
    RECEIPT
  end

  def zuhan_color
    ZH_COLORS
  end

  def zifu_color
    ZF_COLORS
  end

  def express
    express =[[I18n.t('express.in_province'), [X.new(1, I18n.t('express.v1')), X.new(2,I18n.t('express.v2')), X.new(3,I18n.t('express.v3'))]],
              [I18n.t('express.out_province'), [X.new(4,I18n.t('express.v4')), X.new(5,I18n.t('express.v5'))]]]
  end

  def getValue(level1, level2)
    PCB_JSON[level1][level2.to_s]
  end

  private

  def data
    PCB_JSON
  end


end
