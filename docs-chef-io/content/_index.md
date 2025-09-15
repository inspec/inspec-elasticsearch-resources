+++
title = "About Chef InSpec Elasticsearch resources"
platform = "elasticsearch"
draft = false
linkTitle = "Elasticsearch resources"
summary = "Chef InSpec resources for auditing Elasticsearch"
gh_repo = "inspec-elasticsearch-resources"

[menu.elasticsearch]
title = "About resources"
identifier = "inspec/resources/elasticsearch/about"
parent = "inspec/resources/elasticsearch"
+++

The Chef InSpec Elasticsearch resources allow you to audit an Elasticsearch cluster.

## Support

The InSpec Elasticsearch resources were part of InSpec core through InSpec 6.
Starting in InSpec 7, they're released separately as a Ruby gem.

## Usage

To add this resource pack to an InSpec profile, add the `inspec-elasticsearch-resources` gem as a dependency in your `inspec.yml` file:

```yaml
depends:
 - name: inspec-elasticsearch-resources
    gem: inspec-elasticsearch-resources
```

## Elasticsearch resources

{{< inspec_resources_filter >}}

The following Chef InSpec Elasticsearch resources are available in this resource pack.

{{< inspec_resources section="elasticsearch" platform="elasticsearch" >}}
