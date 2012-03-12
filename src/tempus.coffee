#  Project: Tempus jQuery Plugin
#  Description: quick, intuitive time input tool
#  Author: Danny Whalen
#  License: MIT

# Note that when compiling with coffeescript, the plugin is wrapped
# in another anonymous function. We do not need to pass in undefined
# as well, since coffeescript uses (void 0) instead.
(($, window, document) ->
  # window and document are passed through as local variables rather than
  # globals as this (slightly) quickens the resolution process and can be
  # more efficiently minified.

  # Create the defaults once
  pluginName = 'tempus'
  defaults =
    containerMargin: 4

  # The plugin constructor
  class Tempus
    constructor: (element, options) ->
      @self = $(element)
      @config = $.extend {}, defaults, options
      @init()

    init: ->
      @self.focus(@focus).blur(@blur).click(@click)

    focus: =>
      @buildDisplay() if not @container
      @container.show()

    blur: =>
      @container.hide()

    click: (e) =>
      e.preventDefault()
      @focus()

    buildDisplay: ->
      @container = $("<div class='tempus-container'></div>")
      @container[0].innerHTML = @buildUnits()
      @container.appendTo(@self.parent())

    buildUnits: ->
      units = []
      units.push(@buildUnit('ampm', ampm)) for ampm in ['am', 'pm']
      units.push(@buildUnit('hour', hour)) for hour in [1..12]
      units.push(@buildUnit('minute', minute)) for minute in [0, 15, 30, 45]
      units.push(@buildUnit('second', second)) for second in [0, 15, 30, 45]
      units.join('')

    buildUnit: (unit, value) ->
      "<div class='tempus-unit' data-unit='#{unit}' data-value='#{value}'>#{value}</div>"
        
    container_position: ->
      position =
        left: 12 #@self.position().left
        top: @self.position().top + @self.outerHeight() + @config.containerMargin

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Tempus(@, options))
)(jQuery, window, document)
