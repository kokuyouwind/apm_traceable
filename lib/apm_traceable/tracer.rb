# frozen_string_literal: true

module ApmTraceable
  # トレース対象クラスにincludeして利用するTracerクラス
  # トレースに利用する以下2メソッドが利用可能になる
  #   - trace_span: 指定したブロックをトレースする
  #   - trace_methods: 指定したメソッドの呼び出し全体をトレースする
  module Tracer
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    # include先クラスで利用可能にするクラスメソッド群のモジュール
    module ClassMethods
      # 指定したメソッド群をトレース対象にする.
      # 引数を複数指定すると、すべてのメソッドがそれぞれトレース対象になる.
      #
      # fg.
      # class Test
      #   include DatadogTraceable
      #   trace_methods :method_a, :method_b
      # end
      def trace_methods(*method_names)
        # 計測対象をラップする必要があるため、計測対象メソッドと同名で計測用メソッドを定義したモジュールを生成する
        wrapper = Module.new do
          method_names.each do |method_name|
            define_method method_name do |*args, **options, &block|
              trace_span(method_name.to_s) { super(*args, **options, &block) }
            end
          end
        end

        # 計測対象メソッドより先に計測用メソッドが呼び出されないといけないため、
        # prependして継承チェインの先頭側に追加する
        prepend(wrapper)
      end
    end

    # 指定したブロックをトレース対象にする. Datadog::Tracing#trace のラッパーメソッド.
    # リソース名指定のみ必須で、それ以外に指定したオプションは Datadog::Tracing#trace にそのまま渡される.
    #
    # fg.
    # class Test
    #   include DatadogTraceable
    #
    #   def test_method
    #     trace_span('mySpan') { some_heavy_process }
    #   end
    # end
    def trace_span(trace_name, **options, &block)
      ApmTraceable.configuration.adapter.trace(trace_name, context_class: context_class, **options, &block)
    end

    private

    def context_class
      self.class
    end
  end
end
