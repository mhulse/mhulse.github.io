---
image1:
  template: "test.html"
  src: "PEEPS-2011-sketches.jpg"
  caption: "Original **character** sketches."
  wrap: "scroll"
audio1:
  template: "test.html"
  files:
    - "foo1"
    - "foo2"
    - "foo3"
---

{% nada image1 %}

{% nada audio1 foo="baz" %}

{% nada template="test.html" foo="baz" %}

