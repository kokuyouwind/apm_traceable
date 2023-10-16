# frozen_string_literal: true

require 'benchmark'

module ApmTraceable
  module Adapters
    # 標準出力へトレース結果を送るためのアダプター
    class StdoutAdapter < BaseAdapter
      def trace(trace_name, context_class:, **_options, &block)
        result = nil
        traced_sec = Benchmark.realtime do
          result = block.call
        end
        puts "#{context_class&.name}##{trace_name} #{format('%05.6f', traced_sec)}s"
        result
      end
    end
  end
end
