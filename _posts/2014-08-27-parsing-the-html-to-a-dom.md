---
layout: post
title: Parsing the HTML to a DOM Tree
categories: beginners-series front-end
---

The hierarchical structure of an HTML page is usually accessed via a data structure called the
DOM. Most programming languages have libraries that let you convert an HTML page into a DOM. Why do
we do this? HTML pages are just a long list of textual characters - for a programming language to
understand what _elements_ (another word for tags) are contained in the document, the text has to be
_parsed_ into a format that's easier for a script to manipulate. The DOM is one such format.

A DOM structure usually converts an HTML document into a _tree_. The tree has a _root_ - which
corresponds to the element that contains the entire document, typically, either a "dummy" root that
refers to the HTML document type, or to the tag `<html>`. The root element, also referred to as the
_root node_, has a list of _child nodes_ that correspond to each tag contained within the root
tag. Each of those child nodes will have further child nodes, because they might in turn contain
HTML tags, in the HTML document. For example, here's what the "tree structure" of a very simple HTML
document (note that the root node here is the "dummy" mentioned above):

![DOM tree example]({{ site.url }}assets/html_hierarchy.gif)

# Printing Out Nodes

Nodes typically have the following information that you're usually looking for:

* Its name
* A list of its attributes, and the key/value components of each attribute
* A list of the node's child nodes

## Content Nodes

One of the special child nodes of any node is its _content node_. In an HTML document, the only text that is shown on the screen by the browser is the text in a content node. Note that in an HTML document, the content node is the one that has *no tag*. This can be confusing sometimes when inspecting an HTML document visually - unless you pay careful attention to the open and close tags, you might not be able to easily figure out where the content nodes are.

An additional complication is that the content nodes of _some_ tags, notably the `<script>` and
`<style>` tags, are *not* displayed by the browser, even though visually they look the same as the
content child of any other tag, like an `h1` tag, for example.

# Searching in the DOM tree

To locate a specific tag in an HTML document, you can _walk_ the DOM tree - start at the root node,
check if the node you're looking for is one of the root's children, and if not, then repeat the
process with the children of each child node, and so on.

This can get cumbersome when trying to locate more than one node - let's say, you're trying to find
all the links in a document. You'd have to start at the root node, and keep track of every node that
corresponds to the `<a>` tag (the _anchor_ tag.)

Instead, most DOM parsing libraries come with a couple of ways of instantly identifying all nodes with a specific name, or with certain attributes.

The most popular DOM parsing library in Ruby is *[Nokogiri](http://www.nokogiri.org/)* - this code snippet, for example, opens a file and counts how many list item tags are in it (to understand the `css` method, read on to the next section.)

{% highlight ruby %}

{% include code/nokogiri.rb %}

{% endhighlight %}

In this lesson, we'll look at one way of doing this - `CSS Selectors`.

## Using a CSS Selector

A _CSS Selector_ is a pattern that denotes a search within a DOM tree. The simplest CSS selector is simply the name of a tag, and it means, "Search for all nodes with this name." 

For example, to search for all anchor (`a`) tags, you would use the following method call to `css`:

{% highlight ruby %}

    all_a_links = dom.css('a')

{% endhighlight %}

Sometimes there might be too many tags with the same name - in fact, most HTML documents are
dominated by two tags - `<div>` and `<span>` tags. The reason for this is that there's been a shift
to move away from a multitude of tags, each with its own special behavior, to having a small number
of tags, whose behavior is modified by using _stylesheets_ rather than by being implicit in the name
of the tag.

The most visible effect of this change is that fewer HTML pages now use the `<table>` tag (and other
corresponding tags), used to visualize information in a tabular form. Instead, the visual parameters
of tables in HTML pages - width and height, size of the table's cell borders, etc. - are now defined
in stylesheets.

Coming back to CSS selectors - if there are lots of `<div>` tags in a document, how do you know which one you want to select? That problem is usually solved by most HTML (or we can refer to them as "front-end") developers by adding either a `class` or an `id` attribute to a tag. This leads to corresponding CSS selectors, as follows:

* To search for all tags with a specific `id` attribute value: `tagname#id_value` - note the `#` character.
* To search for all tags with a specific `class` attribute value (aka, a _class name_): `tagname.classname` - note the period between the two parts.

{% highlight ruby %}

# This searches for all divs with the class name 'title-text'
title_text_divs = dom.css('div.title-text')

{% endhighlight %}

CSS selectors are used not just in parsing a DOM tree, but also in specifying the style for nodes, using cascading stylesheets. This lesson doesn't address how CSS works when applying styles - for a good introductory start, check out [the Mozilla Developer Network Guide to Getting Started with CSS](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Getting_Started/What_is_CSS).

The [next post in this series on SQL basics](<< next_post_by_cat >>) will cover the use of SQL - we will see how to get the information we obtain from a webpage into a local (relational) database.

# References 

* Some tutorials on DOM: [A free video tutorial on Lynda](http://www.lynda.com/HTML-tutorials/What-Document-Object-Model-DOM/122462/137616-4.html)
* CSS
  * [How to use CSS to style your HTML](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Getting_Started/What_is_CSS)
  * More on selectors: [the basics](http://code.tutsplus.com/tutorials/the-30-css-selectors-you-must-memorize--net-16048)
