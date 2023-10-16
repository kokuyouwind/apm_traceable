# frozen_string_literal: true

require_relative 'apm_traceable/adapters/base_adapter'
require_relative 'apm_traceable/adapters/stdout_adapter'
require_relative 'apm_traceable/configuration'
require_relative 'apm_traceable/tracer'
require_relative 'apm_traceable/version'

# ApmTraceable 全体のモジュール
module ApmTraceable
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
