Version History
====
    * All Version bumps are required to update this file as well!!
----

* 1.0.1 - Fix namespacing bug for Cortex::Snippets::Client
* 1.0.0 - Multi-tenancy Rebuild, now takes in Cortex Client
* 0.8.1 - Dependency upgrades, etc
* 0.8.0 - Add Dynamic Yield Metadata
* 0.7.0 - Add SEO Robot Metadata
* 0.6.0 - Set SEO Keyword feed to be an array rather than comma separated String
* 0.5.3 - Extract a framework-agnostic sanitized_webpage_url method
* 0.5.2 - Addendum to previous version: fix expiry issues
* 0.5.1 - Set Webpage feed cache to never expire
* 0.5.0 - Auto-inject Client Helper into Views/Controllers. Add 10s race condition resolution to Rails cache fetch. Pass through to Snippet tag entire set of HTML attributes. Implement new namespacing and support Bundler.require.
