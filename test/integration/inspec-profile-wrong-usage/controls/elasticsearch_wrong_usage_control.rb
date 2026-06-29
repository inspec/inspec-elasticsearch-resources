# frozen_string_literal: true

# ─── Wrong usage error handling ───────────────────────────────────────────────
#
# All controls below exercise incorrect or edge-case usage of the elasticsearch
# resource. Before the fix, these would crash with raw Ruby errors (e.g.
# NoMethodError). After the fix, each should SKIP with a descriptive message.
#
# To run:
#   bundle exec inspec exec test/integration/inspec-profile-wrong-usage
# ──────────────────────────────────────────────────────────────────────────────

# Scenario 1: URL passed as a bare String instead of a Hash key.
# Before fix: NoMethodError — String does not respond to #fetch
# After fix:  SKIP — "elasticsearch resource requires a Hash of options"
control "elasticsearch-wrong-usage-string-arg" do
  title "elasticsearch resource skips gracefully when a String is passed instead of a Hash"
  desc  "Passing a plain URL string (e.g. elasticsearch('http://localhost:9200')) is " \
        "incorrect usage. The resource should skip with a helpful message instead of " \
        "raising a NoMethodError."
  impact 0.5

  describe elasticsearch("http://localhost:9200") do
    # This block will not be evaluated — the resource skips before reaching here.
    its("cluster_name") { should_not be_nil }
  end
end

# Scenario 2: Elasticsearch not running — connection refused.
# Before fix: Raw curl stderr bubbled up as an unhandled crash in some paths.
# After fix:  SKIP — "Connection refused - please check the URL"
control "elasticsearch-wrong-usage-not-running" do
  title "elasticsearch resource skips gracefully when Elasticsearch is not running"
  desc  "When Elasticsearch is not installed or not running on the target node, " \
        "the resource should skip with a clear connection-refused message."
  impact 0.5

  describe elasticsearch(url: "http://localhost:9200") do
    its("cluster_name") { should_not be_nil }
  end
end

# Scenario 3: URL points to a non-Elasticsearch HTTP endpoint.
# Before fix: NoMethodError — response JSON lacks '_nodes', crashing on nil['successful']
# After fix:  SKIP — "missing '_nodes' field"
control "elasticsearch-wrong-usage-wrong-endpoint" do
  title "elasticsearch resource skips gracefully when the URL is not an Elasticsearch endpoint"
  desc  "When the URL resolves but returns JSON that is not an Elasticsearch /_nodes " \
        "response (missing the '_nodes' field), the resource should skip with a " \
        "descriptive message instead of crashing."
  impact 0.5

  describe elasticsearch(url: "http://localhost:80") do
    its("node_count") { should >= 1 }
  end
end

# Scenario 4: Correct Hash-based usage with default URL — skips when ES is absent.
# This matches the documented example usage of the resource.
control "elasticsearch-wrong-usage-default-url" do
  title "elasticsearch resource skips gracefully when ES is absent using default URL"
  desc  "Using the correct Hash-based API but targeting a host where Elasticsearch " \
        "is not running. Expected to SKIP — Elasticsearch is not installed on the test node."
  impact 0.5

  describe elasticsearch do
    its("cluster_name") { should_not be_nil }
  end
end
