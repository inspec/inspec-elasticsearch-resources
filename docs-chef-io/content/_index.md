+++
title = "About Chef InSpec Elasticsearch resources"
platform = "elasticsearch"
draft = false
linkTitle = "Elasticsearch resources"
summary = "Chef InSpec resources for auditing Elasticsearch"

[cascade]
  [cascade.params]
    gh_repo = "inspec-elasticsearch-resources"
    platform = "elasticsearch"

[menu.elasticsearch]
title = "About resources"
identifier = "inspec/resources/elasticsearch/about"
parent = "inspec/resources/elasticsearch"
+++

The Chef InSpec Elasticsearch resources allow you to audit and test the configuration, status, and security of Elasticsearch clusters.

## Support

The InSpec Elasticsearch resources were originally included as part of InSpec core through version 6. Starting with InSpec 7, they are distributed separately as a Ruby gem.

## Usage

To use these resources in an InSpec profile, add the `inspec-elasticsearch-resources` gem as a dependency in your `inspec.yml` file:

```yaml
depends:
  - name: inspec-elasticsearch-resources
    gem: inspec-elasticsearch-resources
```

## Elasticsearch resources

{{< inspec_resources_filter >}}

The following Chef InSpec Elasticsearch resources are available in this resource pack.

{{< inspec_resources section="elasticsearch" platform="elasticsearch" >}}
