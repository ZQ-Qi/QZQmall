// Some general UI pack related JS
// Extend JS String with repeat method
String.prototype.repeat = function (num) {
  return new Array(Math.round(num) + 1).join(this);
};

(function ($) {
  'use strict';

  // Add segments to a slider
  $.fn.addSliderSegments = function () {
    return this.each(function () {
      var $this = $(this),
          option = $this.slider('option'),
          amount = (option.max - option.min)/option.step,
          orientation = option.orientation;
      if ( 'vertical' === orientation ) {
        var output = '', i;
        //console.log(amount);
        for (i = 1; i <= amount - 1; i++) {
            output += '<div class="ui-slider-segment" style="top:' + 100 / amount * i + '%;"></div>';
        }
        $this.prepend(output);
      } else {
        var segmentGap = 100 / (amount) + '%';
        var segment = '<div class="ui-slider-segment" style="margin-left: ' + segmentGap + ';"></div>';
        $this.prepend(segment.repeat(amount - 1));
      }
    });
  };

  $(function () {

    // Custom Selects
    if ($('[data-toggle="select"]').length) {
      $('[data-toggle="select"]').select2();
    }

    // Checkboxes and Radiobuttons

    $('[data-toggle="checkbox"]').radiocheck();
    $('[data-toggle="radio"]').radiocheck();

    // Tabs
    $('.nav-tabs a').on('click', function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

    // Tooltips
    $('[data-toggle="tooltip"]').tooltip();

    // Popovers
    $('[data-toggle="popover"]').popover();

    // jQuery UI Sliders
    var $slider = $('#slider');
    if ($slider.length > 0) {
      $slider.slider({
        max: 15,
        step: 6,
        value: 3,
        orientation: 'horizontal',
        range: 'min'
      }).addSliderSegments();
    }

    var $slider2 = $('#slider2');
    if ($slider2.length > 0) {
      $slider2.slider({
        min: 1,
        max: 5,
        values: [3, 4],
        orientation: 'horizontal',
        range: true
      }).addSliderSegments($slider2.slider('option').max);
    }

    var $slider3 = $('#slider3');
    var slider3ValueMultiplier = 100;
    var slider3Options;

    if ($slider3.length > 0) {
      $slider3.slider({
        min: 1,
        max: 5,
        values: [3, 4],
        orientation: 'horizontal',
        range: true,
        slide: function (event, ui) {
          $slider3.find('.ui-slider-value:first')
            .text('$' + ui.values[0] * slider3ValueMultiplier)
            .end()
            .find('.ui-slider-value:last')
            .text('$' + ui.values[1] * slider3ValueMultiplier);
        }
      });

      slider3Options = $slider3.slider('option');
      $slider3.addSliderSegments(slider3Options.max)
        .find('.ui-slider-value:first')
        .text('$' + slider3Options.values[0] * slider3ValueMultiplier)
        .end()
        .find('.ui-slider-value:last')
        .text('$' + slider3Options.values[1] * slider3ValueMultiplier);
    }

    var $verticalSlider = $('#vertical-slider');
    if ($verticalSlider.length) {
      $verticalSlider.slider({
        min: 1,
        max: 5,
        value: 3,
        orientation: 'vertical',
        range: 'min'
      }).addSliderSegments($verticalSlider.slider('option').max, 'vertical');
    }

    // Add style class name to a tooltips
    $('.tooltip').addClass(function () {
      if ($(this).prev().attr('data-tooltip-style')) {
        return 'tooltip-' + $(this).prev().attr('data-tooltip-style');
      }
    });

    // Placeholders for input/textarea
    $(':text, textarea').placeholder();

    // Make pagination demo work
    $('.pagination').on('click', 'a', function () {
      $(this).parent().siblings('li').removeClass('active').end().addClass('active');
    });

    $('.btn-group').on('click', 'a', function () {
      $(this).siblings().removeClass('active').end().addClass('active');
    });

    // Disable link clicks to prevent page scrolling
    $(document).on('click', 'a[href="#fakelink"]', function (e) {
      e.preventDefault();
    });

    // Focus state for append/prepend inputs
    $('.input-group:not(.fileinput)').on('focus', '.form-control', function () {
      $(this).closest('.input-group, .form-group').addClass('focus');
    }).on('blur', '.form-control', function () {
      $(this).closest('.input-group, .form-group').removeClass('focus');
    });

    // Table: Toggle all checkboxes
    $('.table .toggle-all :checkbox').on('click', function () {
      var $this = $(this);
      var ch = $this.prop('checked');
      $this.closest('.table').find('tbody :checkbox').radiocheck(!ch ? 'uncheck' : 'check');
    });

    // Table: Add class row selected
    $('.table tbody :checkbox').on('change.radiocheck', function () {
      var $this = $(this);
      var check = $this.prop('checked');
      var checkboxes = $this.closest('.table').find('tbody :checkbox');
      var checkAll = checkboxes.length === checkboxes.filter(':checked').length;

      $this.closest('tr')[check ? 'addClass' : 'removeClass']('selected-row');
      $this.closest('.table').find('.toggle-all :checkbox').radiocheck(checkAll ? 'check' : 'uncheck');
    });

    // Switches
    if ($('[data-toggle="switch"]').length) {
      $('[data-toggle="switch"]').bootstrapSwitch();
    }

    // Typeahead
    if ($('#typeahead-demo-01').length) {
      var states = new Bloodhound({
        datumTokenizer: function (d) { return Bloodhound.tokenizers.whitespace(d.word); },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        limit: 4,
        local: [
          { word: 'Alabama' },
          { word: 'Alaska' },
          { word: 'Arizona' },
          { word: 'Arkansas' },
          { word: 'California' },
          { word: 'Colorado' }
        ]
      });

      states.initialize();

      $('#typeahead-demo-01').typeahead(null, {
        name: 'states',
        displayKey: 'word',
        source: states.ttAdapter()
      });
    }


    $('.todo').on('click', 'li', function () {
      $(this).toggleClass('todo-done');
    });

    // make code pretty
    window.prettyPrint && prettyPrint();

    // fix dropdown in pagination on mobile
    // $(window).resize(function () {
    //   $('.pagination ul').each(function () {
    //     var $parent = $(this);
    //     $parent.find('.pagination-dropdown').each(function () {
    //       var $this = $(this);
    //       //console.log($parent.get(0).scrollWidth + " " + $parent.innerWidth() );
    //       if ($parent.get(0).scrollWidth > $parent.innerWidth()) {
    //         $this.addClass('place-in-row');
    //       } else {
    //         $this.removeClass('place-in-row');
    //       }
    //     });
    //   });
    // }).trigger('resize');
  });
}(jQuery));
