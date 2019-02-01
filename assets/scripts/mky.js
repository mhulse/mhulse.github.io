/*

YES, I KNOW, THIS CODE NEEDS SOME HOUSE CLEANING!

*/

(function(window) {

  'use strict';

  var $ = Sizzle;
  var w = window.innerWidth;
  var h = window.innerHeight;
  var canvii;
  var contexts = [];
  var fps = 15;
  //var p;
  var now;
  var then = Date.now();
  var interval = (1000 / fps);
  var delta;
  var delay;
  // '▀', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█', '▉', '▊', '▋', '▌', '▍', '▎', '▏', '▐',
  var chars = ['░', '▒', '▓', '▔', '▕', '▖', '▗', '▘', '▙', '▚', '▛', '▜', '▝', '▞', '▟', '─', '━', '│', '┃', '┄', '┅', '┆', '┇', '┈', '┉', '┊', '┋', '┌', '┍', '┎', '┏', '┐', '┑', '┒', '┓', '└', '┕', '┖', '┗', '┘', '┙', '┚', '┛', '├', '┝', '┞', '┟', '┠', '┡', '┢', '┣', '┤', '┥', '┦', '┧', '┨', '┩', '┪', '┫', '┬', '┭', '┮', '┯', '┰', '┱', '┲', '┳', '┴', '┵', '┶', '┷', '┸', '┹', '┺', '┻', '┼', '┽', '┾', '┿', '╀', '╁', '╂', '╃', '╄', '╅', '╆', '╇', '╈', '╉', '╊', '╋', '╌', '╍', '╎', '╏', '═', '║', '╒', '╓', '╔', '╕', '╖', '╗', '╘', '╙', '╚', '╛', '╜', '╝', '╞', '╟', '╠', '╡', '╢', '╣', '╤', '╥', '╦', '╧', '╨', '╩', '╪', '╫', '╬', '╭', '╮', '╯', '╰', '╱', '╲', '╳', '╴', '╵', '╶', '╷', '╸', '╹', '╺', '╻', '╼', '╽', '╾', '╿'];
  var l = chars.length;

  window.requestAnimationFrame = (function () {
    return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || function (callback) {
      window.setTimeout(callback, 1000 / 60);
    };
  })();

  var sizer = function(canvas) {

    canvas.width = (w + 400);
    canvas.height = (h + 400);
    canvas.style.width = (w + 400) + 'px';
    canvas.style.height = (h + 400) + 'px';

  };

  var draw = function(context, iterator) {


    // Might not want to calculate width/height each time:
    var x = ((0.5 + (Math.random() * context.canvas.offsetWidth)) || 0);
    var y = ((0.5 + (Math.random() * context.canvas.offsetHeight)) || 0);
    var char = chars[Math.floor(Math.random() * l)];
    var font = ((iterator * 4) + 'vmin monospace');
    var fill = '#fff';
    var alpha = (((iterator + 1) * 1.25) / 10);
    var rotation = (Math.random() * 1);
    //var coords = { top: y, right: (x + Math.ceil(context.measureText(char).width)), bottom: (y + parseInt(font)), left: x };

    context.fillStyle = fill;
    context.font = font;
    context.fillText(char, x, y);
    context.globalAlpha = alpha;
    context.rotate(rotation);

  };

  var loop = function(contexts) {

    //console.log(contexts)

    window.requestAnimationFrame(function() {

      loop(contexts);

    });

    now = Date.now();
    delta = now - then;

    if (delta > interval) {

      then = now - (delta % interval);

      _.each(contexts, function(context, iterator) {

        draw(context, iterator);

      });

    }

  };

  window.addEventListener('load', function() {

    canvii = $('canvas');
    var context;

    _.each(canvii, function(canvas) {

      sizer(canvas);
      context = canvas.getContext('2d');
      context.globalAlpha = 0;

      contexts.push(context);

    });

    delay = _.delay(function() {
      clearTimeout(delay);
      loop(contexts);
    }, 3000);

  });

})(window);

(function() {

  'use strict';

  var $ = Sizzle;

  var container = $('#container')[0];

  var maxSearchIterations = 10;
  var min_x = 0;
  var max_x = container.offsetWidth;
  var min_y = 0;
  var max_y = container.offsetHeight;
  var filled_areas = [];

  function calc_overlap(a1) {
    var overlap = 0;
    for (var i = 0; i < filled_areas.length; i++) {

      var a2 = filled_areas[i];

      // no intersection cases
      if (a1.x + a1.width < a2.x) {
        continue;
      }
      if (a2.x + a2.width < a1.x) {
        continue;
      }
      if (a1.y + a1.height < a2.y) {
        continue;
      }
      if (a2.y + a2.height < a1.y) {
        continue;
      }

      // intersection exists : calculate it !
      var x1 = Math.max(a1.x, a2.x);
      var y1 = Math.max(a1.y, a2.y);
      var x2 = Math.min(a1.x + a1.width, a2.x + a2.width);
      var y2 = Math.min(a1.y + a1.height, a2.y + a2.height);
      var intersection = ((x1 - x2) * (y1 - y2));

      overlap += intersection;

      // console.log("( "+x1+" - "+x2+" ) * ( "+y1+" - "+y2+" ) = " + intersection);
    }

    // console.log("overlap = " + overlap + " on " + filled_areas.length + " filled areas ");
    return overlap;
  }

  function randomize() {

    filled_areas.splice(0, filled_areas.length);

    //var index = 0;
    _.each($('h3'), function(word) {
      var rand_x = 0;
      var rand_y = 0;
      var i = 0;
      var smallest_overlap = 9007199254740992;
      var best_choice;
      var area;
      for (i = 0; i < maxSearchIterations; i++) {
        rand_x = Math.round(min_x + ((max_x - min_x) * (Math.random() % 1)));
        rand_y = Math.round(min_y + ((max_y - min_y) * (Math.random() % 1)));
        area = {
          x: rand_x,
          y: rand_y,
          width: word.offsetWidth,
          height: word.offsetHeight
        };
        var overlap = calc_overlap(area);
        if (overlap < smallest_overlap) {
          smallest_overlap = overlap;
          best_choice = area;
        }
        if (overlap === 0) {
          break;
        }
      }

      filled_areas.push(best_choice);
      /*
      $(this).css({
        position: "absolute",
        "z-index": index++
      });
      */

      word.style.left = rand_x + 'px';
      word.style.top = rand_y + 'px';
      word.style.transform = 'rotate(' + (Math.random() * 360) + 'deg)';

      // console.log("and the winner is : " + smallest_overlap);
    });

    return false;

  }

  window.addEventListener('load', function() { randomize(); });

})();

(function() {

  /* Totally temp. Need to replace with CSS version! */

  'use strict';

  var $ = Sizzle;
  var h3 = $('h3');

  function randRange(data) {
    var newTime = data[Math.floor(data.length * Math.random())];
    return newTime;
  }

  function toggleSomething() {

    if (h3.length) {
      var timeArray = new Array(200, 300, 150, 250, 2000, 3000, 1000, 1500);

      // do stuff, happens to use jQuery here (nothing else does)
      h3[0].style.visibility = 'visible';
      h3.shift();

      clearInterval(timer);
      timer = setInterval(toggleSomething, randRange(timeArray));
    } else {
      clearInterval(timer);
    }
  }

  var timer = setInterval(toggleSomething, 1000);
  // 1000 = Initial timer when the page is first loaded

})();

window.onload = function() {

  'use strict';

var layer0 = document.getElementById('layer0');
  var layer1 = document.getElementById('layer1');

var layer2 = document.getElementById('layer2');

var layer3 = document.getElementById('layer3');

var layer4 = document.getElementById('layer4');

var layer5 = document.getElementById('layer5');

  function parallax(e){

    var xPosition = e.clientX; //it stores the mouse X position

    var yPosition = e.clientY; //it stores the mouse Y position and both //changes with mouse move event per pixel.

    // Now we will change the X position of each layer on mouse move, to provide the smooth and slow effect we will divide position with some numbers.

    layer0.style.left=(xPosition/10)+'px';layer0.style.top=(yPosition/10)+'px';
    layer5.style.left=(xPosition/20)+'px';layer5.style.top=(yPosition/20)+'px';
    layer4.style.left=(xPosition/40)+'px';layer4.style.top=(yPosition/40)+'px';
    layer3.style.left=(xPosition/60)+'px';layer3.style.top=(yPosition/60)+'px';
    layer2.style.left=(xPosition/80)+'px';layer2.style.top=(yPosition/80)+'px';
    layer1.style.left=(xPosition/100)+'px';layer1.style.top=(yPosition/100)+'px';
  }

document.addEventListener('mousemove',parallax);

};
