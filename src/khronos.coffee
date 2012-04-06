#  Project: Tempus jQuery Plugin
#  Description: quick, intuitive time input tool

# Note that when compiling with coffeescript, the plugin is wrapped
# in another anonymous function. We do not need to pass in undefined
# as well, since coffeescript uses (void 0) instead.
(($, window, document) ->
  # window and document are passed through as local variables rather than
  # globals as this (slightly) quickens the resolution process and can be
  # more efficiently minified.

  # Create the defaults once
  pluginName = 'khronos'
  defaults =
    containerMargin: 4

  # The plugin constructor
  class Tempus
    constructor: (element, options) ->
      @self = $(element)
      @config = $.extend {}, defaults, options
      @units =
        ampm: ['am','pm']
        hour: [12,1,2,3,4,5,6,7,8,9,10,11]
        minute: [0,15,30,45]
        second: [0,15,30,45]
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
      @container = $("<div class='khronos-container'></div>")
      @container.appendTo(@self.parent()).position(@containerPosition())
      @container[0].innerHTML = @buildUnits()

    buildUnits: ->
      units = []
      for unitType in ['ampm', 'hour', 'minute', 'second']
        units.push(@buildUnit(unitType, val)) for val in @units[unitType]
      units.join('')

    buildUnit: (unit, value) ->
      "<div class='khronos-unit' data-unit='#{unit}' data-value='#{value}'>#{value}</div>"
        
    containerPosition: ->
      position =
        left: @self.position().left
        top: @self.position().top + @self.outerHeight() + @config.containerMargin

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Tempus(@, options))
)(jQuery, window, document)
