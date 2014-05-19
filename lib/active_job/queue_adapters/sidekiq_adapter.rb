require 'sidekiq'

module ActiveJob
  module QueueAdapters
    class SidekiqAdapter
      class << self
        def queue(job, *args)
          JobWrapper.perform_async(job, *args)
        end
      end

      class JobWrapper
        include Sidekiq::Worker

        def perform(job_name, *args)
          job_name.constantize.perform *Parameters.deserialize(args)
        end
      end
    end
  end
end
