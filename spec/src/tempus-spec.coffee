describe 'Tempus', ->
  beforeEach ->
    setFixtures(sandbox())
    @input = $('<input id="time-input" type="text" name="input" value>')
    $('#sandbox').append(@input)
    @input.tempus()
    @tempus = $.data($('#time-input')[0], 'plugin_tempus')
  
  it "appends the time unit elements to the container", ->
    @input.focus()
    children = $('.tempus-container').children()
    expect(children.length).toEqual(12+4+4+2)

  it "displays the container element only on focus", ->
    expect($('.tempus-container')).not.toExist()
    @input.focus()
    expect($('.tempus-container')).toBeVisible()

  it "hides the container element on blur", ->
    @input.focus()
    @input.blur()
    expect($('.tempus-container')).toBeHidden()

  it "builds an individual am/pm unit element", ->
    unit = @tempus.buildUnit('ampm', 'am')
    expect(unit).toEqual("<div class='tempus-unit' data-unit='ampm' data-value='am'>am</div>")

  it "builds an individual hour element", ->
    unit = @tempus.buildUnit('hour', 5)
    expect(unit).toEqual("<div class='tempus-unit' data-unit='hour' data-value='5'>5</div>")

  it "builds an individual minute element", ->
    unit = @tempus.buildUnit('minute', 15)
    expect(unit).toEqual("<div class='tempus-unit' data-unit='minute' data-value='15'>15</div>")

  it "builds an individual second element", ->
    unit = @tempus.buildUnit('second', 30)
    expect(unit).toEqual("<div class='tempus-unit' data-unit='second' data-value='30'>30</div>")

  it "builds the correct elements", ->
    units = @tempus.buildUnits()
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
    cssPosition = $('.tempus-container').css('position')
    expect(cssPosition).toEqual('absolute')
    
  it "positions the container below the input with configurable margin", ->
    @input.focus()
    top = $('.tempus-container').position().top
    expect(top).toEqual(@input.position().top + @input.outerHeight() + @tempus.config.containerMargin)

  it "position aligns the left edges of the container and the input", ->
    @input.focus()
    left = $('.tempus-container').position().left
    expect(left).toEqual(@input.position().left)
  
  
