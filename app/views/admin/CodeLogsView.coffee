RootView = require 'views/core/RootView'
template = require 'templates/admin/codelogs'
CocoCollection = require 'collections/CocoCollection'
CodeLog = require 'models/CodeLog'
utils = require 'core/utils'


module.exports = class CodeLogsView extends RootView
  template: template
  id: 'code-logs-view'
  events:
    'click .playback': 'onClickA'
    'blur #tooltip': 'deleteTooltip'
  constructor: (options) ->
    @spade = new Spade()
    super options
    @codelogs = new CocoCollection([],
      url: '/db/codelogs'
      model: CodeLog
    )
    #console.log @codelogs
    @listenTo(@codelogs, 'sync', @onThangsLoaded)
    @supermodel.loadCollection(@codelogs, 'codelogs')
      
  onThangsLoaded: ->
    console.log @codelogs
    @renderSelectors '#codelogtable'
    ###
    @processedThangs = @thangs.filter (_elem) ->
      # Case-insensitive search of input vs name.
      return ///#{$('#nameSearch')[0].value}///i.test _elem.get('name')
    for thang in @processedThangs
      thang.tasks = _.filter thang.attributes.tasks, (_elem) ->
        # Similar case-insensitive search of input vs description (name).
        return ///#{$('#descSearch')[0].value}///i.test _elem.name
    @renderSelectors '#thangTable'
    ###
  onClickA: (e) ->
    console.log e
    @deleteTooltip()
    events = LZString.decompressFromUTF16($(e.target).data('codelog'))
    events = @spade.expand(JSON.parse(events))
    tooltip = document.createElement('textarea')
    tooltip.style.position = 'absolute'
    tooltip.style.left = e.pageX + 20 + "px"
    tooltip.style.top = e.pageY + "px"
    tooltip.style.width = "512px"
    tooltip.style.height = "512px"
    tooltip.style.borderRadius = "8px"
    tooltip.id = "codelogs-tooltip"
    tooltip.addEventListener 'blur', @deleteTooltip
    document.body.appendChild tooltip
    @spade.play(events, tooltip)
    #@spade.debugPlay(events)
  deleteTooltip: (e) ->
    tooltip = document.getElementById 'codelogs-tooltip'
    if tooltip?
      tooltip.parentNode.removeChild(tooltip)
