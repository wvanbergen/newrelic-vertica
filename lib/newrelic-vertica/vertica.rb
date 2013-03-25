require 'new_relic/agent/method_tracer'

DependencyDetection.defer do
  depends_on do
    defined?(::Vertica)
  end

  executes do
    ::Vertica::Connection.class_eval do
      add_method_tracer :query, 'Database/Vertica/query'
      add_method_tracer :copy, 'Database/Vertica/copy'
    end
  end
end
