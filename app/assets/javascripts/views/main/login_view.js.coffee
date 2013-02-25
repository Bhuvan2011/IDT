Idt.Views.Main ||= {}

class Idt.Views.Main.LoginView extends Backbone.View
  template: JST['main/login_view_template']

  events:
    'change #email': 'onChangeEmail'
    'change #user_name': 'onChangeUserName'
    'click #login_button': 'onClickSubmit'

  initialize: ->
    console.log("Log in View has been Initialized")
    @notAdminView = new Idt.Views.Main.NotAdminView()
    @users = new Idt.Collections.Users()
    @users.fetch({success: @onFetchSuccess})
    console.log(@users)
    Backbone.Mediator.sub('admin:page', @adminPage, @)
    

  # Properties:
  #
  onFetchSuccess: =>
    @usersView = new Idt.Views.Main.UsersView(collection: @users) 

  # Methods:

  render: ->
    $(@el).html(@template())

  getEmailInputEl: ->
    @$el.find('#email')

  getUserNameInputEl: ->
    @$el.find('#user_name')

  getLoginButtonEl: ->
    @$el.find('#login_button')

  adminPage: (model) =>
    if model.isLoggedIn() and model.isAdmin()
      @$el.html(@usersView.render().el)
    else
      $(@el).append(@notAdminView.render().el)

  # Events:
  onChangeEmail: (event) ->
    @model.setEmail(event.currentTarget.value)

  onChangeUserName: (event) ->
    @model.setUserName(event.currentTarget.value)

  onClickSubmit: (event) ->
    console.log('onClickSubmit')
    event.preventDefault()
    @model.loginViaEmail()

