module ActiveJob
  module QueueAdapters
    class InlineAdapter
      class << self
        def queue(job, *args)
          job.new.perform *Parameters.deserialize(args)
        end

        def queue_at(job, ts, *args)
          # TODO better error handling?
          Thread.new do
            begin
              interval = Time.now.to_f - ts
              sleep(interval) if interval > 0
              job.new.perform *Parameters.deserialize(args)
            rescue => ex
              puts ex.message
            end
          end
        end
      end
    end
  end
end
