Idt.Views.Main ||= {}

class Idt.Views.Main.LoginView extends Backbone.View
  template: JST['main/login_view_template']

  events:
    'change #email': 'onChangeEmail'
    'change #password': 'onChangePassword'
    'click #login_button': 'onClickSubmit'

  initialize: ->
    console.log("Log in View has been Initialized")
    @users = new Idt.Collections.Users()
    @users.fetch()
    console.log(@users)
    @usersView = new Idt.Views.Main.UsersView(collection: @users) 
    Backbone.Mediator.sub('admin:page', @adminPage, @)
    

  # Properties:


  # Methods:

  render: ->
    $(@el).html(@template())

  getEmailInputEl: ->
    @$el.find('#email')

  getPasswordInputEl: ->
    @$el.find('#password')

  getLoginButtonEl: ->
    @$el.find('#login_button')

  adminPage: (model) =>
    if model.isLoggedIn() and model.isAdmin()
      @$el.html(@usersView.render().el)

  # Events:
  onChangeEmail: (event) ->
    @model.setEmail(event.currentTarget.value)

  onChangePassword: (event) ->
    @model.setPassword(event.currentTarget.value)

  onClickSubmit: (event) ->
    console.log('onClickSubmit')
    event.preventDefault()
    @model.loginViaEmail()

