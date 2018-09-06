require 'active_support'
require 'active_support/core_ext'

require "unique_worker/version"
require "unique_worker/lock_manager"

module UniqueWorker
  PREFIX = 'UniqueWorker'
  SEPARATOR = ':'

  mattr_accessor :namespace

  mattr_accessor :disable

  mattr_accessor :redis_servers
  self.redis_servers = ['redis://localhost']

  mattr_accessor :default_lock_timeout_in_seconds
  self.default_lock_timeout_in_seconds = 15.seconds

  mattr_accessor :redlock_options
  self.redlock_options =
    {
      retry_count:   1,
      retry_delay:   10, # milliseconds
      retry_jitter:  50,  # milliseconds
      redis_timeout: 0.1  # seconds
  }

  def self.namespace_to_use
    Rails.env if defined? Rails
  end

  unless disable
    def perform(*args)
      LockManager.lock! [PREFIX, UniqueWorker.namespace_to_use, VERSION, self.class.name].join(SEPARATOR), lock_time_msec do
        super(*args)
      end
    rescue Redlock::LockError => err
      (respond_to?(:logger) ? send(:logger) : Rails.logger).warn "#{self.class.name} worker is locked #{err}"
    end
  end

  private

  def lock_time_msec
    lock_timeout * 1000
  end

  def lock_timeout
    default_lock_timeout_in_seconds
  end
end
