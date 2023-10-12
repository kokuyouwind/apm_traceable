# frozen_string_literal: true

module ApmTraceable
  # 設定値を保持するクラス
  class Configuration
    class InsufficientConfigurationError < StandardError; end

    def service_name
      @service_name || raise(InsufficientConfigurationError, 'service_name is not set')
    end

    attr_writer :service_name
  end
end