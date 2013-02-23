class Idt.Models.Main extends Backbone.Model

  baseUrl: ->
    "http://localhost:3000/"

  url: ->
    @baseUrl()

  defaults:
    current_user: null

  initialize: ->
    console.log('Main.initialize()')
    @setCurrentUser(new Idt.Models.User())

  # Properties:

  getCurrentUser: ->
    @get('current_user')

  setCurrentUser: (user) ->
    @set('current_user', user)

