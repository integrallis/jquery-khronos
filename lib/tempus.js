(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  (function($, window, document) {
    var Tempus, defaults, pluginName;
    pluginName = 'tempus';
    defaults = {
      containerMargin: 4
    };
    Tempus = (function() {

      function Tempus(element, options) {
        this.click = __bind(this.click, this);
        this.blur = __bind(this.blur, this);
        this.focus = __bind(this.focus, this);        this.self = $(element);
        this.config = $.extend({}, defaults, options);
        this.init();
      }

      Tempus.prototype.init = function() {
        return this.self.focus(this.focus).blur(this.blur).click(this.click);
      };

      Tempus.prototype.focus = function() {
        if (!this.container) this.buildDisplay();
        return this.container.show();
      };

      Tempus.prototype.blur = function() {
        return this.container.hide();
      };

      Tempus.prototype.click = function(e) {
        e.preventDefault();
        return this.focus();
      };

      Tempus.prototype.buildDisplay = function() {
        this.container = $("<div class='tempus-container'></div>");
        this.container[0].innerHTML = this.buildUnits();
        return this.container.appendTo(this.self.parent());
      };

      Tempus.prototype.buildUnits = function() {
        var ampm, hour, minute, second, units, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3;
        units = [];
        _ref = ['am', 'pm'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          ampm = _ref[_i];
          units.push(this.buildUnit('ampm', ampm));
        }
        for (hour = 1; hour <= 12; hour++) {
          units.push(this.buildUnit('hour', hour));
        }
        _ref2 = [0, 15, 30, 45];
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          minute = _ref2[_j];
          units.push(this.buildUnit('minute', minute));
        }
        _ref3 = [0, 15, 30, 45];
        for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
          second = _ref3[_k];
          units.push(this.buildUnit('second', second));
        }
        return units.join('');
      };

      Tempus.prototype.buildUnit = function(unit, value) {
        return "<div class='tempus-unit' data-unit='" + unit + "' data-value='" + value + "'>" + value + "</div>";
      };

      Tempus.prototype.container_position = function() {
        var position;
        return position = {
          left: 12,
          top: this.self.position().top + this.self.outerHeight() + this.config.containerMargin
        };
      };

      return Tempus;

    })();
    return $.fn[pluginName] = function(options) {
      return this.each(function() {
        if (!$.data(this, "plugin_" + pluginName)) {
          return $.data(this, "plugin_" + pluginName, new Tempus(this, options));
        }
      });
    };
  })(jQuery, window, document);

}).call(this);
