# encoding: utf-8
require 'clockwork'
require 'lingman'
require 'active_support/time'

def work_or_study
  time = ( ( Time.now.beginning_of_week - Time.new('1970 00:00:00') ) / 60 / 60 / 24 / 7 ).to_i

  week = time.even? ? "学習" : "作業"
  "今日は第#{time}週目の#{week}週です。"
end

module Clockwork
  handler do |job|
    puts "#{job}"
    Lingman::Updater.update(ENV['BOTID'], ENV['ROOMID'], ENV['SECRET'], work_or_study)
  end

  every(1.day, 'work_or_study', at: '10:00')
  every(1.day, 'work_or_study', at: '21:00')
end
