---
layout: post
title: What is HTTP? How Web Applications and Browsers Communicate
categories: beginners-series http
---

Web applications are typically written as computer programs that run constantly, waiting for _requests_ from browsers
running on other computers. Those computers can be someone's desktop, laptop, or mobile phone. The browser requests are
usually made by a human being who clicks on a link in a webpage (or in her email,) and expects to see a webpage as a
result. The job of the web application is to respond with the code corresponding to the webpage that the browser can
interpret correctly.

Browsers (and the human beings behind them) aren't the only ones making requests to web applications. Sometimes, it's another program that's talking to the web application - robots talking to robots. In fact, most Internet traffic is automated - ["non-human" traffic outnumber human-originated web traffic](http://www.cnet.com/news/bots-now-running-the-internet-with-61-percent-of-web-traffic/). 

A web application is required to do *two* things:

1. Run constantly, waiting for requests
1. Accept requests that are formatted in a special _protocol_, called the Hyper Text Transfer Protocol, or HTTP, and generate a corresponding response that's in the HTTP format as well. This is why when you type in a webpage _URL_ into a browser's address bar, you (frequently) prefix it [^1] with the letters "h-t-t-p".

Computer programs that run constantly are also referred to conventionally as _servers_. Hence, a web application is also sometimes called a _web server_. 

In this article, we'll dig deeper into the second aspect of web applications - what is HTTP?

# The Structure Of An HTTP Message

Whether a request or a response, an HTTP message is required to contain two essential parts - the request's _headers_
and its _body_. 

The headers typically describe something about the communication between the browser and the server itself; hence, they are referred to as containing _metadata_ - which means, "data that is about (some other) data." For example, a header might have information about the length of the body, or about what type of data is in the body (an image, say.)

The body of the HTTP response typically contains _HTML_ (Hyper Text Markup Language) code, the language understood by
browsers, but that's not always the case.

## HTTP Headers

There is no definitive list of all headers - partly because the _specification_ for HTTP allows for custom headers and different web applications will add headers that they can understand and use. But there are some headers that are required.

The most important header *in an HTTP request* that you should wrap your head around is the one that contains the _method_ information. Each HTTP request consists of two essential parts:

1. A _resource_, that gives the web application some information about what data on the server is being requested
2. A _method_, that says what the web application should do with the data referenced in the _resource_.

There are [many HTTP methods](http://www.iana.org/assignments/http-methods/http-methods.xhtml) that a browser can send in an HTTP request, but the two you will most often encounter are GET and POST.

The resource is usually everything you see in the browser address bar after the server name, that is, the "www.google.com" part. If you type in any website name into the browser and hit Enter, you will see that the browser adds a '`/`' at the end of the website name. That means that by default, the resource in the request is simple that - the '`/`' (or _slash_) symbol.

It's easy to observe these headers using your browser - either Chrome or Firefox. Here, we'll use Firefox and its "Inspect Element" feature - right click on any webpage and you'll see this information under the Network tab. (On Chrome, you can get similar information using the Developer Tools interface under the Settings button at the top-right of the Chrome window.) You might have to hit refresh on the browser first.

Below, we have the [XKCD website](http://www.xkcd.com) up, and you can see it generates a host of GET requests and one POST request.

![Network Tab in Firefox Inspect Element]({{ site.url }}assets/network tab inspect firefox.png)

In [the follow-up to this lesson](--next_post_by_cat--), we will go into more detail into how HTTP headers are constructed, and what the HTTP response looks like.

# Advanced Topics

* Find out how non-human originators of requests - bots - announce themselves in order to differentiate themselves from humans. Why might bots want to do this?
* Find out what an _RFC_ is. 
  * See if you can track down a "satirical" or "joke" or "fake" RFC.
  * Can you understand the RFC process enough and be inspired by it enough, to write a "joke" RFC yourself?

# Quick Links 

Here are some links we've shared in this article.

* HTTP
  * [The HTTP 1.1 specification](http://tools.ietf.org/html/rfc2616), aka RFC 2616 (quasi-latest, as of Sep 2014).
  * A list of HTTP methods, aka [the HTTP method registry](http://www.iana.org/assignments/http-methods/http-methods.xhtml)
* lists of HTTP headers

[^1]: And even if you don't type in "http," your browser will automatically, silently, do it for you.
