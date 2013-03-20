(function($){
  var d = function() {
    console.debug.apply(console, arguments);
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

  $.cookie('tollerdata_generations', generations);

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
    div.children(".below").children(".titles").html(titles(json));
  }

  var render_about = function(div, indi, json) {
    render_name(div, indi, json);
    render_titles(div, indi, json);

    div.children(".below").children(".hips").html(hips(json));
    div.children(".below").children(".heart").html(heart(json));
    div.children(".below").children(".longevity").html(longevity(json));
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

    $("#spinner > span").spinner({
      incremental: false,
      min: 1,
      max: 10,
      start: function(){
        d("start");
        d(generations);
        d($(this).spinner().val());
      },
      stop: function(){
        d("stop");
        generations = $(this).spinner().val();
        d(generations);

        if (generations < 1) {
          generations = 1;
        }
        if (generations > 8) {
          generations = 8;
        }

        $(this).spinner().val(generations);
        d("s "+$(this).spinner().val());
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

  });
}(jQuery));
