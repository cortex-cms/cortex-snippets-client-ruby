# Cortex Snippets Client

This is the Ruby Client of the Snippets Library for [Cortex](https://github.com/cortex-cms). The purpose of this gem is to create a simplified way of accessing the content of snippets that are modifiable in the Cortex IPE and rendering them as useable markup, as well as the various other attributes of Webpages.

##Installation


To Install simply run

```ruby
gem install cortex-snippets-client
```

Or if you're installing from a Gemfile include it as

```ruby
gem 'cortex-snippets-client`, '~> 1.0.4'
```

And then run 

```ruby
bundle install
```

##Setup


In order to get started using the Cortex Snippets Client you're going to need to initialize a [Cortex Client](https://github.com/cortex-cms/cortex-client-ruby) object that you will be using to interact with Cortex. You will need a separate client for each tenant you have active.

The following is a basic setup for a Cortex Client:

```ruby
$cortex = Cortex::Client.new(
				  key: 1234567,
                  secret: ABCDEFG,
                  base_url: http://localhost:3000,
                  scopes: view:webpages)
```

Once you have your Cortex Client object you can simply initialize and store a Cortex Snippet Client object by creating it like so:

```ruby
@cortex_snippet_client = Cortex::Snippets::Client.new($cortex)
```

##Usage


Use of this gem is generally split into two categories: Snippets and Webpages

**Snippets** refers to blocks of markup that are editable in Cortex IPE and, through the use of this gem, persist into the tenant application. This allows the copy changes made in IPE to replace default blocks on the page and your changes to be shown.

**Webpages** refer to the created webpages themselves, which have several bits of relevant metadata including, but not limited to: title, keywords, and indexing information. 

###Snippets


**Basic Usage**

To be properly used, snippets must have both a reference in the Markup:

```haml
# A view in your application

= snippet :id => 'a_snippet_name' do
  %h1.heavy
    This is my awesome title
```

And a call to the Snippets Client:

```ruby
# app/helpers/application_helper.rb

def snippet(options = {}, &block)
  @cortex_snippet_client.snippet(request, options, capture(&block))
end
```

This will take the given id of the snippet, search the relevant Cortex Tenant for any matches, and return a block of content - if it does not find a match it will simply return the default block of Markup.

**Additional Usage**

Any additional metadata you pass into the `options` hash will extend to the final, rendered snippet. For example:

```haml
# A view in your application

= snippet :id => 'a_snippet_name', :class => 'some_test_class' do
  %h1.heavy
    This is my awesome title
```

Will result in the following markup being rendered:

```html
<snippet id="a_snippet_name" class="some_test_class">
  <h1 class="heavy">
	This is my awesome title
  </h1>
</snippet>
```

###Webpages

The webpage system of this gem is used quite differently, in order to properly reference it you will need to do the following:

```ruby
webpage = @cortex_snippet_client.current_webpage(request)
```

This will give you a webpage object from your current Cortex Tenant with all of the given metadata for that page as attributes. Here is a comprehensive list of accessible information for any Webpage:

|Attribute|Description|
|---|---|
|seo_title| The title for the current Webpage.|
|seo_description| The description of the current Webpage.|
|seo_keywords| An array of search keywords for the current Webpage.<sup>1</sup>|
|seo_robots| An array of indexing robot information for the current Webpage.<sup>2</sup>|
|noindex| The noindex information for the Webpage. Included in `seo_robots`|
|nofollow| The nofollow information for the Webpage. Included in `seo_robots`|
|noodp| The noodp information for the Webpage. Included in `seo_robots`|
|nosnippet| The nosnippet information for the Webpage. Included in `seo_robots`|
|noarchive| The noarchive information for the Webpage. Included in `seo_robots`|
|noimageindex| The noimageindex information for the Webpage. Included in `seo_robots`|
|dynamic_yield| A hash of Dynamic Yield information from the current Webpage.|
|snippets|An array of the associated snippets with the current Webpage.|


1:<br>
The resulting array from `seo_keywords` can be entered into a single keyword meta tag like so:

```haml
%meta{name: 'keywords', content: webpage.seo_keywords.join(',') }
```

2:<br>
The resulting array from `seo_robots` can be entered into a single robots meta tag like so:

```haml
%meta{name: 'robots', content: webpage.seo_robots.join(',') }
```

## Changelog
See [CHANGELOG.md](CHANGELOG.md) for a comprehensive and updated history of changes to this gem. Additionally this gem uses GitHub version, so you can go there and see any general release notes.

## Contributing
The following is in addition to the usual GitHub flow (fork the repo, pull it down locally, etc...)

* If you would like to contribute to this gem please create a branch entitled `issue/#{GitHub Issue Number}-#{Issue Name}`. If you are submitting a new feature without an attached issue then name your branch `feature/#{Descriptive Feature Name}`
* Make your changes locally and write tests for all created changes
* For any added commits please follow the patterns of [Semantic Git Commits](https://github.com/ElliottAYoung/git-semantic-commits)
* Create a Pull Request in which you detail what you changed, why you changed it, and every other relevant detail to your PR. If your PR is for an open issue please link to that.
* Correspond with us! (We're really very nice)
* When it's accepted and approved we will merge in your code!!

## License
Apache License, Version 2.0