describe 'Tempus', ->
  beforeEach ->
    setFixtures(sandbox())
    @input = $('<input id="time-input" type="text" name="input" value>')
    $('#sandbox').append(@input)
    @input.khronos()
    @khronos = $.data($('#time-input')[0], 'plugin_khronos')
  
  it "appends the time unit elements to the container", ->
    @input.focus()
    children = $('.khronos-container').children()
    expect(children.length).toEqual(12+4+4+2)

  it "displays the container element only on focus", ->
    expect($('.khronos-container')).not.toExist()
    @input.focus()
    expect($('.khronos-container')).toBeVisible()

  it "hides the container element on blur", ->
    @input.focus()
    @input.blur()
    expect($('.khronos-container')).toBeHidden()

  it "builds an individual am/pm unit element", ->
    unit = @khronos.buildUnit('ampm', 'am')
    expect(unit).toEqual("<div class='khronos-unit' data-unit='ampm' data-value='am'>am</div>")

  it "builds an individual hour element", ->
    unit = @khronos.buildUnit('hour', 5)
    expect(unit).toEqual("<div class='khronos-unit' data-unit='hour' data-value='5'>5</div>")

  it "builds an individual minute element", ->
    unit = @khronos.buildUnit('minute', 15)
    expect(unit).toEqual("<div class='khronos-unit' data-unit='minute' data-value='15'>15</div>")

  it "builds an individual second element", ->
    unit = @khronos.buildUnit('second', 30)
    expect(unit).toEqual("<div class='khronos-unit' data-unit='second' data-value='30'>30</div>")

  it "builds the correct elements", ->
    units = @khronos.buildUnits()
    unitTypes = $(units).map (i, el) -> $(el).data('unit')
    ampmCount = hourCount = minuteCount = secondCount = 0
    ampmCount += 1 for t in unitTypes when t is 'ampm'
    hourCount += 1 for t in unitTypes when t is 'hour'
    minuteCount += 1 for t in unitTypes when t is 'minute'
    secondCount += 1 for t in unitTypes when t is 'second'
    expect(ampmCount).toEqual(2)
    expect(hourCount).toEqual(12)
    expect(minuteCount).toEqual(4)
    expect(secondCount).toEqual(4)

  it "position the container absolutely", ->
    @input.focus()
    cssPosition = $('.khronos-container').css('position')
    expect(cssPosition).toEqual('absolute')

  it "positions the container below the input with configurable margin", ->
    @input.focus()
    top = $('.khronos-container').position().top
    expect(top).toEqual(@input.position().top + @input.outerHeight() + @khronos.config.containerMargin)

  it "vertically aligns the left edges of the container and the input", ->
    @input.focus()
    left = $('.khronos-container').position().left
    expect(left).toEqual(@input.position().left)
  
  it "", ->
