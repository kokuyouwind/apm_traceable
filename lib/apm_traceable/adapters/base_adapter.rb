# frozen_string_literal: true

module ApmTraceable
  module Adapters
    # トレース結果を送信するためのアダプターのベースクラス
    # @abstract
    class BaseAdapter
      def trace(trace_name, context_class:, **_options, &_block)
        raise NotImplementedError
      end
    end
  end
end
