---
layout: "post"
date: "2010-06-11 02:52:49"
title: "Go Entertainment"
deck: "The event source for Lane County"
categories: ["web", "logo"]
tags: ["code", "django", "design"]
fig1:
  image: "go.png"
fig2:
  image: "go-logos.png"
  caption: "Logo variations."
head_extra: |
  <style>
    #go_widget_01 { text-align: left; margin: 0 auto; }
    #go_widget_01 li:before { display: none; content: ''; }
  </style>
---

{% nada fig2 %}

---

### Arts events calendar “go” is online

The newsroom last week began to beta launch a new “go” entertainment events site at [registerguard.com](http://www.registerguard.com/). The idea for this project has been to capture content into a live, searchable database—a community calendar of events online—that news can then reverse publish to the print edition without a lot of duplicated effort. The concept is that news sources and eventually community members can upload information themselves without news aides, reporters or editors having to generate it. Deputy Managing Editor Carl Davaz has headed up the project.

“A big round of applause for John Heasly and Micky Hulse for working so hard and creatively over the past few months to make this project come together” Carl said. “Thanks also to Lisa Crossley, Steve Collier and Mark Johnson as we’ve tried to leverage their ideas and preserve their calendar workflow.”

The intention throughout the project has been to connect the community with this calendar. Initial meetings with Arts & Business Alliance leaders helped to refine the concept. Arts organizations around the city have begun to participate in the process by using the direct conduit to contribute content. The editors feel there’s been a lot of enthusiasm. First tier contributors will be able upload events via spreadsheets and enhance calendar entries with expanded descriptions, including images and embedded video and audio.

“Go Entertainment” is available under the Entertainment menu at [registerguard.com](http://www.registerguard.com/) or by entering the address [registerguard.com/go](http://www.registerguard.com/go).

“Visually it’s a pretty simple design” Carl explains. “Featured entertainment events attract attention. Visitors can search for events in several ways. You can search by category at the top of the page. You can search by date on the widget or the calendar. The widget can be shared with other sites. And you can search by venue at the bottom of the page.”

Other content includes latest blog posts, limited recent entertainment/arts stories and reviews from the print edition. Non-Flash picture presentations are viewable on any mobile device.

It will be an advertising-supported site, but to limit clutter for visitors and provide the best environment for advertisers, we’re limiting the ads to two online standard ad units, the leaderboard and box ad.

Next phases of development will focus on a new mobile presentation format and the addition of other features like supplementing entries with Facebook commenting.

Ultimately, “go” will have a broader mission to include events other than entertainment, such as community events, sports, business—really anything that readers will want to know about and go to.

---

Dynamic Go calendar widget, sans-jQuery:

<script>
    var go_widget_style = true;                // Default: true
    var go_widget_identifier = 'go_widget_01'; // Default: ''
    var go_widget_item_count = 3;              // Default: 10 (min = 1, max = 50)
    var go_widget_item_category = '';          // Default: 'all'
    var go_widget_link = true;                 // Default: true
    var go_widget_width = '350px';             // Default: auto (you must specify a unit)
    var go_widget_day_count = 5;               // Default: 5 (min = 1, max = 25)
    var go_widget_color_01 = '#306f00';        // Default: #306f00
    var go_widget_color_02 = '#fff';           // Default: #fff
    var go_widget_color_03 = '#c7e2b2';        // Default: #c7e2b2
    var go_widget_color_04 = '#459e00';        // Default: #459e00
    var go_widget_color_05 = '#306f00';        // Default: #306f00
    var go_widget_color_06 = '#639';           // Default: #639
    var go_widget_color_07 = '#52297a';        // Default: #52297a
    var go_widget_color_08 = '#377e00';        // Default: #377e00
    var go_widget_color_09 = '#7b3706';        // Default: #7b3706
    var go_widget_color_10 = '#fff4ce';        // Default: #fff4ce
    var go_widget_color_11 = '#ffedad';        // Default: #ffedad
    var go_widget_color_12 = '#cd5c0a';        // Default: #cd5c0a
</script>
<script src="http://go.registerguard.com/tools/widget.js"></script>

Embed code:

```html
<script>
    var go_widget_style = true;                // Default: true
    var go_widget_identifier = 'go_widget_01'; // Default: ''
    var go_widget_item_count = 3;              // Default: 10 (min = 1, max = 50)
    var go_widget_item_category = '';          // Default: 'all'
    var go_widget_link = true;                 // Default: true
    var go_widget_width = '350px';             // Default: auto (you must specify a unit)
    var go_widget_day_count = 5;               // Default: 5 (min = 1, max = 25)
    var go_widget_color_01 = '#306f00';        // Default: #306f00
    var go_widget_color_02 = '#fff';           // Default: #fff
    var go_widget_color_03 = '#c7e2b2';        // Default: #c7e2b2
    var go_widget_color_04 = '#459e00';        // Default: #459e00
    var go_widget_color_05 = '#306f00';        // Default: #306f00
    var go_widget_color_06 = '#639';           // Default: #639
    var go_widget_color_07 = '#52297a';        // Default: #52297a
    var go_widget_color_08 = '#377e00';        // Default: #377e00
    var go_widget_color_09 = '#7b3706';        // Default: #7b3706
    var go_widget_color_10 = '#fff4ce';        // Default: #fff4ce
    var go_widget_color_11 = '#ffedad';        // Default: #ffedad
    var go_widget_color_12 = '#cd5c0a';        // Default: #cd5c0a
</script>
<script src="http://go.registerguard.com/tools/widget.js"></script>
```
