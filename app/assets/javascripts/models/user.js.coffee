class Idt.Models.User extends Backbone.Model

  paramRoot: 'user'

  baseUrl: ->
    "http://localhost:3000" + '/users'

  url: ->
    @baseUrl()

  defaults:
    id: null
    logged_in: false
    registered: false
    first_name: ''
    last_name: ''
    user_name: ''
    roles: ''
    admin: false

  initialize: ->


  # Properties:

  getId: ->
    @get('id')

  setId: (id) ->
    @set('id', id)

  setErrors: (errors) ->
    @set('errors', errors)

  getErrors: ->
    @get('errors')

  setEmail: (email) ->
    @set('email', email)

  getEmail: ->
    @get('email')

  setFirstName: (first_name) ->
    @set('first_name', first_name)

  getFirstName: ->
    @get('first_name')

  setUserName: (user_name) ->
    @set('user_name', user_name)

  getUserName: ->
    @get('user_name')

  setRoles: (roles) ->
    @set('roles', roles)

  getRoles: ->
    @get('roles')

  setLastName: (last_name) ->
    @set('last_name', last_name)

  getLastName: ->
    @get('last_name')

  setLoggedIn: (loggedIn = true) ->
    @set('logged_in', loggedIn)

  isLoggedIn: ->
    @get('logged_in')

  setAdmin: (admin = true) ->
    @set('admin', admin)

  isAdmin: ->
    @get('admin')
  

  setPassword: (password) ->
    @set('password', password)

  getPassword: ->
    @get('password')

  setPasswordConfirmation: (passwordConfirmation) ->
    @set('password_confirmation', passwordConfirmation)

  getPasswordConfirmation: ->
    @get('password_confirmation')

  
  loginViaEmail: ->
    user_name = @getUserName()
    email = @getEmail()
    @url = ->
      "http://localhost:3000/registrations/login"
    ajax = $.ajax(
      type: "POST"
      url: "http://localhost:3000/registrations/login"
      data: {"user":{"email":email,"user_name":user_name}}
    )
    ajax.fail => alert "Wrong Credentials"
    ajax.success (data) =>
      console.log("success")
      window.accessToken = data.token
      @set(data)
      @setLoggedIn(true)
      @setAdmin(true) if data.user.admin
      Backbone.Mediator.pub('admin:page', @)      

  register: () ->
    @url = ->
      "http://localhost:3000/registrations"
    @save()  
      # @save(null, {
      #success: (model, response, options) =>
      # @setRegistered()
      #error: (model, xhr, options) =>
      #  console.log('error')
      #  @set(JSON.parse(model.responseText))
      #})

class Idt.Collections.Users extends Backbone.Collection
  model: Idt.Models.User
  url: -> 'http://localhost:3000/users'


