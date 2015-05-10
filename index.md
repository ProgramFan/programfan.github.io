---
layout: page
title: ProgramFan's Writing Space - Home
---

This is a work in progress. I usually write about some Linux/vim/python/c++ tips here.

I am also writing in more detail about my workspace configuration on http://gitbook.com.

## Blog

I blog about my experiences on using Linux system daily. Here comes the
recommanded posts: 

{% for post in site.posts %}
{% if post.categories contains 'featured' %}
 - [{{ post.title }}]({{ post.url }})
{% endif %}
{% endfor %}
