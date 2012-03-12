(function() {

  describe('Tempus', function() {
    beforeEach(function() {
      setFixtures(sandbox());
      this.input = $('<input id="time-input" type="text" name="input" value>');
      $('#sandbox').append(this.input);
      this.input.tempus();
      return this.tempus = $.data($('#time-input')[0], 'plugin_tempus');
    });
    it("appends the time unit elements to the container", function() {
      var children;
      this.input.focus();
      children = $('.tempus-container').children();
      return expect(children.length).toEqual(12 + 4 + 4 + 2);
    });
    it("displays the container element only on focus", function() {
      expect($('.tempus-container')).not.toExist();
      this.input.focus();
      return expect($('.tempus-container')).toBeVisible();
    });
    it("hides the container element on blur", function() {
      this.input.focus();
      this.input.blur();
      return expect($('.tempus-container')).toBeHidden();
    });
    it("builds an individual am/pm unit element", function() {
      var unit;
      unit = this.tempus.buildUnit('ampm', 'am');
      return expect(unit).toEqual("<div class='tempus-unit' data-unit='ampm' data-value='am'>am</div>");
    });
    it("builds an individual hour element", function() {
      var unit;
      unit = this.tempus.buildUnit('hour', 5);
      return expect(unit).toEqual("<div class='tempus-unit' data-unit='hour' data-value='5'>5</div>");
    });
    it("builds an individual minute element", function() {
      var unit;
      unit = this.tempus.buildUnit('minute', 15);
      return expect(unit).toEqual("<div class='tempus-unit' data-unit='minute' data-value='15'>15</div>");
    });
    it("builds an individual second element", function() {
      var unit;
      unit = this.tempus.buildUnit('second', 30);
      return expect(unit).toEqual("<div class='tempus-unit' data-unit='second' data-value='30'>30</div>");
    });
    it("builds the correct elements", function() {
      var ampmCount, hourCount, minuteCount, secondCount, t, unitTypes, units, _i, _j, _k, _l, _len, _len2, _len3, _len4;
      units = this.tempus.buildUnits();
      unitTypes = $(units).map(function(i, el) {
        return $(el).data('unit');
      });
      ampmCount = hourCount = minuteCount = secondCount = 0;
      for (_i = 0, _len = unitTypes.length; _i < _len; _i++) {
        t = unitTypes[_i];
        if (t === 'ampm') ampmCount += 1;
      }
      for (_j = 0, _len2 = unitTypes.length; _j < _len2; _j++) {
        t = unitTypes[_j];
        if (t === 'hour') hourCount += 1;
      }
      for (_k = 0, _len3 = unitTypes.length; _k < _len3; _k++) {
        t = unitTypes[_k];
        if (t === 'minute') minuteCount += 1;
      }
      for (_l = 0, _len4 = unitTypes.length; _l < _len4; _l++) {
        t = unitTypes[_l];
        if (t === 'second') secondCount += 1;
      }
      expect(ampmCount).toEqual(2);
      expect(hourCount).toEqual(12);
      expect(minuteCount).toEqual(4);
      return expect(secondCount).toEqual(4);
    });
    it("position the container absolutely", function() {
      var cssPosition;
      this.input.focus();
      cssPosition = $('.tempus-container').css('position');
      return expect(cssPosition).toEqual('absolute');
    });
    it("positions the container below the input with configurable margin", function() {
      var top;
      this.input.focus();
      top = $('.tempus-container').position().top;
      return expect(top).toEqual(this.input.position().top + this.input.outerHeight() + this.tempus.config.containerMargin);
    });
    return it("position aligns the left edges of the container and the input", function() {
      var left;
      this.input.focus();
      left = $('.tempus-container').position().left;
      return expect(left).toEqual(this.input.position().left);
    });
  });

}).call(this);
