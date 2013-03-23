(function($){
  var max_ratio = 99;

  var d = function() {
    // throw "a fit";
    if (!console.debug) {
      console.warn(arguments[0]);
    } else {
      console.debug.apply(console, arguments);
    }
  }

  var generations = $.cookie('tollerdata_generations');
  var show_hips = $.cookie('tollerdata_hips');
  var show_heart = $.cookie('tollerdata_heart');
  var show_longevity = $.cookie('tollerdata_longevity');

  if (generations == void(0)) {
    $.cookie('tollerdata_generations', (generations = 4));
  }

  if (generations < 1) {
    generations = 1;
  }
  if (generations > 8) {
    generations = 8;
  }

  // generations = 3;

  $.cookie('tollerdata_generations', generations);

  var _individuals = {}

  fetch = function(id, callback) {
    // d("get "+id);
    $.ajax({
      dataType: "json",
      url: "/tollerdata/animals/"+id+".json",
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
    $("span", div.children(".above").children(".name")).html(indi.name);
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

  var compact = function(actual){
    var newArray = new Array();
    for(var i = 0; i<actual.length; i++){
      if (actual[i]){
        newArray.push(actual[i]);
      }
    }
    return newArray;
  }

  var longevity = function(animal) {
    return "10.5 years";
  }

  var combine = function(json, a, b) {
    return clean(compact([clean(json[a]), clean(json[b])]).join(" "));
  }

  var hips = function(json) {
    return combine(json, "HIPREGISTRY", "HIPID");
  }

  var heart = function(json) {
    return combine(json, "HEARTREGISTRY", "HEARTID");
  }

  var render_titles = function(div, indi, json) {
    $("span", div.children(".below").children(".titles")).html(titles(json));
  }

  var render_about = function(div, indi, json) {
    div.attr("id", "about_"+indi.id);

    render_name(div, indi, json);
    render_titles(div, indi, json);

    var below = div.children(".below");

    $("span", below.children(".hips")).html(hips(json));    
    $("span", below.children(".heart")).html(heart(json));    
    $("span", below.children(".longevity")).html(longevity(json));    
  }

  var add_pedigree = function(div, id, generation) {
    if (!div.length) {
      throw "oops";
      return;
    }

    generation = generation || 0;

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

    // div.attr("id", "individual_"+id);
    div.attr("data-generation",generation);

    // d($(div).data());

    div.children(".about").
      attr("id", "about_"+id);

    $(".name span", div.children(".about")).
      on("click", function(){
        d("click");
        d($(this).closest(".individual")[0]);
        var generation = $(this).closest(".individual").data("generation");
        if (generation > 0) {
          d(generation);
          var id = $(this).closest(".about").attr("id");
          id = id.replace("about_", "");
          d(id);
          window.location = id;
        }
      });

    if (generation >= generations) {
      div.children(".parents").hide();
    }

    var offset = 0;

    $(div).children(".about").css("width", (max_ratio*1/(generations-generation+1)-offset)+"%");
    $(div).children(".parents").css("width", (max_ratio*(1-1/(generations-generation+1))-offset)+"%");

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
                     indi.father_id, generation+1);
        add_pedigree(div.children(".parents").children(".mother").first(),
                     indi.mother_id, generation+1);
      }

      // d(div.children(".about").children(".hr"));
      // d(div.children(".parents").children(".father").children(".about").children(".hr"));
      // d(div.children(".parents").children(".mother").children(".about").children(".hr"));

      // d($("#about_"+indi.id+" .hr"));
      // d($("#about_"+indi.father_id+" .hr"));

      /*
      d({
        source: "#about_"+indi.id+" .hr",
        target: "#about_"+indi.father_id+" .hr"
      });
      */

      var source = $("#about_"+indi.id+" .hr");
      var mother = $("#about_"+indi.mother_id+" .hr");
      var father = $("#about_"+indi.father_id+" .hr");

      if (mother.length > 0) {
        jsPlumb.connect({
          source: source,
          target: mother,
          anchors:[ "BottomRight", "BottomLeft" ],
          endpoint: "Blank",
	  connector:"Straight",
          paintStyle:{ strokeStyle:"black", lineWidth:2 },
        });
      }

      if (father.length > 0) {
        jsPlumb.connect({
          source: source,
          target: father,
          anchors:[ "RightMiddle", "LeftMiddle" ],
          endpoint: "Blank",
	  connector:"Straight",
          paintStyle:{ strokeStyle:"black", lineWidth:2 },
        });
      }

      jsPlumb.repaintEverything();
    });
  }

  var resize = function(generations){
    d("resize "+generations);
    $(".individual").each(function(){
      var generation = $(this).data("generation");
      if (generation == void(0)) {
        return;
      }
      // d("");
      // d(generation+" "+generations);
      // d(this);
      if (generation > generations) {
        return;
        d("2 hide");
        d($(this)[0]);
        $(this).hide();
        return;
      }
      var ratio;
      if (generation < generations) {
        ratio = 1/(generations-generation+1)*max_ratio;
      } else {
        ratio = max_ratio;
      }
      if (true) {
        var duration = 500;
        $(this).children(".about").animate({
          width:ratio+"%",
        },{
          duration: duration,
        });
        $(this).children(".parents").animate({
          width:(max_ratio-ratio)+"%"
        }, duration);
/*
        if (ratio < 100) {
          $(this).children(".parents").width((100-ratio)+"%").show();
        } else {
          $(this).children(".parents").hide();
        }
*/
      } else {
        // d(ratio);
        $(this).children(".about").width(ratio+"%");
        // d(100-ratio);
        if (ratio < max_ratio) {
          d("1 show");
          d($(this).children(".parents")[0]);
          $(this).children(".parents").width((max_ratio-ratio)+"%").show();
        } else {
          d("0 hide");
          d($(this).children(".parents")[0]);
          $(this).children(".parents").hide();
        }
      }
      // d(this);
      // d(ratio);
      // d("");
    });
  }

  $(function(){
    // jsPlumb.setRenderMode(jsPlumb.CANVAS);

    $("#spinner > span").spinner({
      incremental: false,
      min: 1,
      max: 10,
/*
      start: function(){
        d("start");
        d(generations);
        d($(this).spinner().val());
      },
*/
      stop: function(){
        var now = $(this).spinner().val();

        if (now < 1) {
          now = 1;
        }
        if (now > 8) {
          now = 8;
        }

        d(generations+" > "+now);

        if (now != generations) {
          resize(parseInt(now));
        }
/*
        if (now > generations) {
        } else if (generations > now) {
          d($('*[data-generation="'+generations+'"]').length);
          $('*[data-generation="'+generations+'"]').hide();
        }
*/

        // d("stop");
        generations = now;
        // d(generations);

        $(this).spinner().val(generations);
        // d("s "+$(this).spinner().val());
        $.cookie('tollerdata_generations', generations);
        $(".generations .value").html($(this).spinner().val());
      }
    }).val(generations);

    // d("v "+generations);

    $(".generations .value").html(generations);

    div = $(".new_pedigree").first();
    id = div && div.data("animal-id");
    if (div && id) {
      add_pedigree(div, id);
    }

    $(".hips_button input").
      prop("checked", show_hips).
      click(function(){
        // d("clicked");
        var show_hips = $(this).prop("checked");
        $.cookie('tollerdata_hips', show_hips);
        if (show_hips) {
          $(".hips").show();
        } else {
          $(".hips").hide();
        }
      }).click().click();

    $(".heart_button input").
      prop("checked", show_heart).
      click(function(){
        // d("clicked");
        var show_heart = $(this).prop("checked");
        $.cookie('tollerdata_heart', show_heart);
        if (show_heart) {
          $(".heart").show();
        } else {
          $(".heart").hide();
        }
      }).click().click();

    $(".longevity_button input").
      prop("checked", show_longevity).
      click(function(){
        // d("clicked");
        var show_longevity = $(this).prop("checked");
        $.cookie('tollerdata_longevity', show_longevity);
        if (show_longevity) {
          $(".longevity").show();
        } else {
          $(".longevity").hide();
        }
      }).click().click();

    $("#image img").css("max-height", $("#metadata").height());
    
    $(window).resize(function(){
      $("#image img").css("max-height", $("#metadata").height());
      jsPlumb.repaintEverything();
    });
    
    $(".fetch_ofa").on("click", function(){
      var id = $("body > .title").data("animal-id");
      d("fetch ofa "+id);
    });

  });
}(jQuery));
