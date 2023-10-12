# frozen_string_literal: true

module ApmTraceable
  module Adapters
    # Datadogへトレース結果を送るためのアダプター
    class DatadogAdapter < BaseAdapter
      def initialize(service_name)
        super()

        @service_name = service_name
      end

      def trace(trace_name, context_class:, **options, &block)
        Datadog::Tracing.trace(
          trace_name,
          **options.merge(service: service_name, resource: resource_name(context_class)),
          &block
        )
      end

      private

      attr_reader :service_name

      def trace_name(context_class)
        # include 先のクラス名を利用して `product.search_controller` のような文字列を作る
        context_class.name.underscore&.tr('/', '.')
      end
    end
  end
end
