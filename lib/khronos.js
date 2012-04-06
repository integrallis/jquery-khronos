(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  (function($, window, document) {
    var Tempus, defaults, pluginName;
    pluginName = 'khronos';
    defaults = {
      containerMargin: 4
    };
    Tempus = (function() {

      function Tempus(element, options) {
        this.click = __bind(this.click, this);
        this.blur = __bind(this.blur, this);
        this.focus = __bind(this.focus, this);        this.self = $(element);
        this.config = $.extend({}, defaults, options);
        this.units = {
          ampm: ['am', 'pm'],
          hour: [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
          minute: [0, 15, 30, 45],
          second: [0, 15, 30, 45]
        };
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
        this.container = $("<div class='khronos-container'></div>");
        this.container.appendTo(this.self.parent()).position(this.containerPosition());
        return this.container[0].innerHTML = this.buildUnits();
      };

      Tempus.prototype.buildUnits = function() {
        var unitType, units, val, _i, _j, _len, _len2, _ref, _ref2;
        units = [];
        _ref = ['ampm', 'hour', 'minute', 'second'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          unitType = _ref[_i];
          _ref2 = this.units[unitType];
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            val = _ref2[_j];
            units.push(this.buildUnit(unitType, val));
          }
        }
        return units.join('');
      };

      Tempus.prototype.buildUnit = function(unit, value) {
        return "<div class='khronos-unit' data-unit='" + unit + "' data-value='" + value + "'>" + value + "</div>";
      };

      Tempus.prototype.containerPosition = function() {
        var position;
        return position = {
          left: this.self.position().left,
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
