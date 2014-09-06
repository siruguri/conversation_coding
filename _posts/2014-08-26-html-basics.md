---
layout: post
title: HTML Basics&#58; Understanding HTML and the DOM
categories: beginners-series front-end
---

To start, let's breeze through a basic understanding of HTML. If you are reading this webpage
in a desktop browser, like Firefox, you should be able to view source, typically via the top-level
menu or the right click menu. You will see the text of the webpage interspersed with what are called
HTML tags, which are text strings prefixed with the `<` character. Here, for example, is the source of this very page:

![View Source Screenshot]({{ site.url }}assets/view_source.png)

The tags are part of the HTML language specification - to put it simply, each tag has a _name_, and
a list of _tag attributes_. The tag attributes are specific as _key/value pairs_, in the form
`key=value`.

Tags define a hierarchical structure - each tag is said to _contain_ one or more other tags, and
the containment is shown by using pairs of _opening_ and _closing_ tags. Closing tags are written
simply in the form `</tag_name>` - note that they start with `</` and end in `>`. Above you'll see that the `<head>` opening tag is closed by a corresponding `</head>` closing tag. Note that not all tags need to come in opening and closing pairs. To learn more about which which tags to close, which not to, and why there's a difference, read [this good blog post on _void elements_](http://www.colorglare.com/2014/02/03/to-close-or-not-to-close.html).

A simple HTML document has the following structure - the entire document is contained inside the
`<html>` tag, and typically, the `<html>` tag contains a minimum of two tags, the `<head>` and the
`<body>` tag.


Additionally, _well-formed_ HTML documents also declare their _document type_, which in the case of an HTML document is, simply, "html".

By convention, some tags are referred to typically by longer names - the `<a>` tag for example is
called the _anchor_ tag; any tag that is the letter `h` followed by a number - like `<h3>` - is
called a _header_ tag; the tag `<li>` is called the _list item_ tag, and so on. Frequently, if not
always, tag names are simply acronyms for the "long name version."

# References

The entire HTML specification will take a while to learn, but some good resources to start from are listed here:

* []()

Our [next lesson is on understanding how to convert this HTML hierarchy into a
"DOM"](--next_post_by_cat--) - away of turning a page full of HTML text into something you can easily
manipulate in a program.

