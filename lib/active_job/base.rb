require 'active_job/queue_adapter'
require 'active_job/queue_adapters/inline_adapter'
require 'active_support/core_ext/string/inflections'

module ActiveJob
  class Base
    extend QueueAdapter

    cattr_accessor(:queue_base_name) { "active_jobs" }
    cattr_accessor(:queue_name)      { queue_base_name }

    class << self
      def enqueue(*args)
        queue_adapter.queue self, *args
      end

      def queue_as(part_name)
        self.queue_name = "#{queue_base_name}_#{part_name}"
      end
    end
  end
end