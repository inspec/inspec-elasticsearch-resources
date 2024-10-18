# frozen_string_literal: true
describe elasticsearch(ssl_verify: false) do
  its("node_count") { should >= 3 }
end

describe elasticsearch do
  its("node_name") { should include "node1" }
  its("os") { should_not include "MacOS" }
  its("version") { should cmp > "1.2.0" }
end


