require 'redlock'

module UniqueWorker
  module LockManager
    class << self
      delegate :lock!, to: :client

      def client
        @client ||= Redlock::Client.new UniqueWorker.redis_servers, UniqueWorker.redlock_options
      end
    end
  end
end
