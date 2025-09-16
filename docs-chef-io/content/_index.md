+++
title = "About the Chef InSpec Elasticsearch resource pack"
draft = false
linkTitle = "Elasticsearch resource pack"
summary = "Chef InSpec resources for auditing Elasticsearch."

[cascade]
  [cascade.params]
    platform = "elasticsearch"

[menu.elasticsearch]
  title = "About Elasticsearch resources"
  identifier = "inspec/resources/elasticsearch/about"
  parent = "inspec/resources/elasticsearch"
  weight = 10
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
