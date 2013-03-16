(function($){
  var d = function() {
    console.debug.apply(console, arguments);
  }

  //
  var canvas = document.createElement('canvas');

  // http://code.google.com/p/explorercanvas/wiki/Instructions#Dynamically_created_elements
  if (!canvas.getContext) G_vmlCanvasManager.initElement(canvas);

  var ctx = canvas.getContext('2d');
  canvas.width = 1;
  canvas.height = 1;

  // for simplicity, assume the input is in rgba format
  function createPixel(r, g, b, a) {
    ctx.fillStyle = 'rgba(' + [r,g,b,a].join() + ')';
    ctx.fillRect(0,0,1,1);
    // 'data:image/png;base64,'.length => 22
    return canvas.toDataURL('image/png','').substring(22);
  }
  //

  var generations = $.cookie('tollerdata_generations');
  
  if (generations == void(0)) {
    $.cookie('tollerdata_generations', (generations = 4));
  }

  generations = 3;

  var _individuals = {}

  fetch = function(id, callback) {
    // d("get "+id);
    $.ajax({
      dataType: "json",
      url: "/tollerdata/animals/"+id,
      success: function(json){
        callback(json);
      },
      error: function(jqxhr, string, error){
        d(jqxhr);
        d(string);
        d(error);
      }
    });
  }

  var with_individual = function(id, callback) {
    var individual;
    if (individual = _individuals[id]) {
      callback(individual);
    } else {
      fetch(id, callback);
    }
  }

  var render_name = function(div, indi) {
    // d("render "+indi.name);
    // d(div);
    div.children(".above").children(".name").html(indi.name);
  }

  var strip = function(string) {
    return string.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
  }

  var squish = function(string) {
    return strip(string).replace(/\s+/g, ' ');
  }

  var blank = function(string) {
    return !string || string.match(/^\s*$/);
  }

  var clean = function(string) {
    // d(string);
    if (string) {
      string = squish(string);;
    }
    return blank(string) ? void(0) : string;
  }

  var prefix = function(json) {
    return clean(json["FRONTTITLES"]);
  }
  
  var suffix = function(json) {
    return clean(json["ENDTITLES"]);
  }
  
  var titles = function(json) {
    var titles = clean([prefix(json), suffix(json)].join(" "));
    // d(prefix(json));
    // d(titles);
    return titles;
  }

  var render_titles = function(div, indi, json) {
    div.children(".below").children(".titles").html(titles(json));
  }

  var render_about = function(div, indi, json) {
    render_name(div, indi, json);
    render_titles(div, indi, json);
  }

  var add_pedigree = function(div, id, generation, first, last) {
    if (!div.length) {
      throw "oops";
      return;
    }

    generation = generation || 0;
    first = first == void(0) ? true : first;
    last = last == void(0) ? true : last;

    if (!$(".individual", div).length) {
      var clone = $("#prototype .individual").first().clone();
      clone 
        .contents()
        .filter(function() {
          return this.nodeType === 3; //Node.TEXT_NODE
        }).
        remove();
      clone.appendTo(div);
    }

    div = div && $(".individual", div).first();

    if (generation >= generations) {
      div.children(".parents").hide();
    }

    if (first) {
      $(div).children(".about").children(".above").css("border-left-color", "transparent");
    } else {
      $(div).children(".about").children(".above").css("border-left-color", "black");
    }
    
    if (last) {
      $(div).children(".about").children(".below").css("border-left-color", "transparent");
    } else {
      $(div).children(".about").children(".below").css("border-left-color", "black");
    }

    $(div).children(".about").css("width", (100*1/(generations-generation+1)-1)+"%");
    $(div).children(".parents").css("width", (100*(1-1/(generations-generation+1))-1)+"%");

    with_individual(id, function(indi){
      var json = indi.import_json;
      if (json) {
        json = $.parseJSON(json);
      }
      // d("about");
      // d(div);
      render_about(div.children(".about").first(), indi, json, generation);

      if (generation < generations) {
        add_pedigree(div.children(".parents").children(".father").first(),
                     indi.father_id, generation+1, true, false);
        add_pedigree(div.children(".parents").children(".mother").first(),
                     indi.mother_id, generation+1, false, true);
      }

    });
  }

  $(function(){
    div = $(".new_pedigree").first();
    id = div && div.data("animal-id");
    if (div && id) {
      add_pedigree(div, id);
    }
  });
}(jQuery));
