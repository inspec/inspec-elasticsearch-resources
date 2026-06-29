# frozen_string_literal: true

if ENV["CI_ENABLE_COVERAGE"]
  require "simplecov/no_defaults"
  require_relative "../helpers/simplecov_minitest"
  SimpleCov.start do
    add_filter "/test/"
    add_group "Resources", ["lib/inspec-elasticsearch-resources/resources"]
  end
end

require "minitest/autorun"
require "minitest/pride"
require "inspec/resource"
require "mocha/minitest"
require "inspec/backend"

module Minitest
  class Test
    def setup
      # TODO: Setup logic
    end
  end
end

def load_elasticsearch_resource(*args)
  # initialize resource with backend and parameters
  resource = "elasticsearch"
  @resource_class = Inspec::Resource.registry[resource]
  raise ArgumentError, "No resource #{resource}" unless @resource_class

  @resource = @resource_class.new(backend, resource, *args)
end

def backend
  return @backend if @backend

  @backend = Inspec::Backend.create(Inspec::Config.mock)
  mock = @backend.backend
  mock.mock_os({ name: "ubuntu", family: "debian", release: "22.04", arch: "x86_64" })
  scriptpath = ::File.expand_path "..", __dir__
  cmd = lambda { |x|
    stdout = ::File.read(::File.join(scriptpath, "/fixtures/" + x))
    mock.mock_command("", stdout, "", 0)
  }
  cmd_stderr = lambda { |stderr_msg|
    mock.mock_command("", "", stderr_msg, 1)
  }

  mock.commands = {
    "curl -H 'Content-Type: application/json' http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-nodes-default"),
    "curl -k -H 'Content-Type: application/json' http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-no-ssl"),
    "curl -H 'Content-Type: application/json'  -u es_admin:password http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-auth"),
    "curl -H 'Content-Type: application/json' http://elasticsearch.mycompany.biz:1234/_nodes" => cmd.call("elasticsearch-cluster-url"),
    "curl -H 'Content-Type: application/json' http://unreachable.example.com:9200/_nodes" => cmd_stderr.call("curl: (7) Failed to connect to unreachable.example.com port 9200: Connection refused"),
    "curl -H 'Content-Type: application/json' http://auth-required.example.com:9200/_nodes" => cmd.call("elasticsearch-cluster-error-response"),
    "curl -H 'Content-Type: application/json' http://no-nodes-field.example.com:9200/_nodes" => cmd.call("elasticsearch-cluster-no-nodes-field"),
    "curl -H 'Content-Type: application/json' http://sparse.example.com:9200/_nodes" => cmd.call("elasticsearch-cluster-sparse-node"),
    "curl -H 'Content-Type: application/json' http://zero-successful.example.com:9200/_nodes" => cmd.call("elasticsearch-cluster-zero-successful"),
    %{sh -c 'type "curl"'} => cmd.call("sh-c-type-curl"),
  }
  @backend
end
