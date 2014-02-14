---
fig1:
  audio:
    - "foo1"
    - "foo2"
    - "foo3"
  video:
    - "foo1"
    - "foo2"
    - "foo3"
  div:
    id: "billy"
    class: "woot"
  figure:
    class: "foo"
  img:
    attributes:
      src: "/foo/bar/billy.jpg"
      class: "billy"
      id: "johnson"
      width: "1"
      height: "1"
---

{% fig fig1 src="/wtf/johnson.png" width="100%" height="100%" class="x6" onclick="return: false;" %}
