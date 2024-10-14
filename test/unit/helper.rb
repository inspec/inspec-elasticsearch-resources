# frozen_string_literal: true

require "minitest/autorun"
require "minitest/unit"
require "minitest/pride"
require "inspec/resource"
require "mocha/minitest"

module Minitest
  class Test
    def setup
      # TODO: Setup logic
    end
  end
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
  mock.commands = {
    "curl -H 'Content-Type: application/json' http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-nodes-default"),
    "curl -k -H 'Content-Type: application/json' http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-no-ssl"),
    "curl -H 'Content-Type: application/json'  -u es_admin:password http://localhost:9200/_nodes" => cmd.call("elasticsearch-cluster-auth"),
    "curl -H 'Content-Type: application/json' http://elasticsearch.mycompany.biz:1234/_nodes" => cmd.call("elasticsearch-cluster-url"),
    %{sh -c 'type "curl"'} => cmd.call("sh-c-type-curl"),
  }
  @backend
end
