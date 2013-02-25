# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require dataTables/jquery.dataTables
#= require underscore
#= require backbone
#= require idt
#= require_self
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./views
#= require_tree .


$ ->
  window.beforeSend = (jqXHR) ->
    console.log('beforeSend...')
    jqXHR.setRequestHeader('X-User-Access-Token', window.accessToken)

  window.oldSync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    console.log('Backbone.sync', [method, model, options])
    options.beforeSend = beforeSend
    window.oldSync(method, model, options)

  $.ajaxSetup(beforeSend: window.beforeSend)

