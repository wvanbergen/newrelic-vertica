require 'new_relic/agent/method_tracer'
require 'benchmark'

module NewRelic
  module Agent
    module Instrumentation
      module VerticaInstrumentation

        def self.included(klass)
          klass.class_eval do
            alias_method :query_without_instrumentation, :query
            alias_method :query, :query_with_instrumentation
          end
        end

        def query_with_instrumentation(sql, options = {}, &block)
          result = nil
          duration = Benchmark.realtime do
            result = query_without_instrumentation(sql, options, &block)
          end

          if NewRelic::Agent.is_execution_traced?
            NewRelic::Agent.instance.transaction_sampler.notice_sql(sql, nil, duration)
          end

          return result
        end
      end
    end
  end
end

DependencyDetection.defer do
  depends_on do
    defined?(::Vertica) && defined?(::Vertica::Connection)
  end

  executes do
    ::Vertica::Connection.instance_eval do
      include ::NewRelic::Agent::Instrumentation::VerticaInstrumentation
    end
  end
end

