RootView = require 'views/core/RootView'
template = require 'templates/admin/codelogs'
CocoCollection = require 'collections/CocoCollection'
CodeLog = require 'models/CodeLog'
utils = require 'core/utils'


module.exports = class CodeLogsView extends RootView
  template: template
  id: 'code-logs-view'
  events:
    'click .playback': 'onClickPlayback'
    'blur #tooltip': 'onBlurTooltip'
  constructor: (options) ->
    @spade = new Spade()
    super options
    @codelogs = new CocoCollection([],
      url: '/db/codelogs'
      model: CodeLog
    )
    @listenTo(@codelogs, 'sync', @onThangsLoaded)
    @supermodel.loadCollection(@codelogs, 'codelogs')
      
  onThangsLoaded: ->
    console.log @codelogs
    @renderSelectors '#codelogtable'

  onClickPlayback: (e) ->
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
    tooltip.addEventListener 'blur', @onBlurTooltip
    document.body.appendChild tooltip
    @spade.play(events, tooltip)
    #@spade.debugPlay(events)
  onBlurTooltip: (e) ->
    tooltip = document.getElementById 'codelogs-tooltip'
    if tooltip?
      tooltip.parentNode.removeChild(tooltip)
