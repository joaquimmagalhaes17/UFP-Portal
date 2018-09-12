# frozen_string_literal: true

require File.dirname(__FILE__) + '/./bot/analysis'

namespace :bot do
  desc 'Check if new grades were released to all users'
  task grades: :environment do
    users = User.where(enable: true)

    semaphore = Concurrent::Semaphore.new(4)
    threads = []

    users.each do |user|
      threads << Thread.new do
        semaphore.acquire

        analysis = Analysis.new(user)
        analysis.start

        semaphore.release
      end
    end

    threads.each(&:join)
  end
end
