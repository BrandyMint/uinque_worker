require "test_helper"
require 'pry'

class UniqueWorkerTest < Minitest::Test
  class TestWorker
    prepend UniqueWorker

    def perform(*args)
      return 'oook'
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::UniqueWorker::VERSION
  end

  def test_it_works
    assert_equal 'oook', TestWorker.new.perform(a: 1)
  end

  def test_it_works_disabled
    UniqueWorker.disable = true
    assert_equal 'oook', TestWorker.new.perform(a: 1)
  end
end
