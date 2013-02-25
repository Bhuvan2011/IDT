Idt.Views.Main ||= {}

class Idt.Views.Main.RegistrationView extends Backbone.View
  template: JST['main/registration_view_template']

  events:
    'change #first_name': 'onChangeFirstName'
    'change #last_name':  'onChangeLastName'
    'change #email': 'onChangeEmail'
    'change #user_name': 'onChangeUserName'
    
  initialize: ->
    @initModelBindings()
    @loginView = new Idt.Views.Main.LoginView()
    

  initModelBindings: ->
    @model.bind('change:errors', @onChangeErrors, @)

  # Properties:

  isRendered: ->
    @rendered

  # View properties:

  getErrorsEl: ->
    @$el.find('#errors')

  getFirstNameInputEl: ->
    @$el.find('#first_name')

  getLastNameInputEl: ->
    @$el.find('#last_name')

  getEmailInputEl: ->
    @$el.find('#email')


  getRegistrationButtonEl: ->
    @$el.find('#registration_button')

  getUserNameEl: ->
    @$el.find('#user_name')


  # View events:

  onChangeFirstName: (event) ->
    @model.setFirstName(event.currentTarget.value)

  onChangeLastName: (event) ->
    @model.setLastName(event.currentTarget.value)

  onChangeEmail: (event) ->
    @model.setEmail(event.currentTarget.value)

  onChangeUserName: (event) ->
    @model.setUserName(event.currentTarget.value)


    
  # Model events:

  onChangeErrors: (user) ->
    console.log('onChangeErrors', user)
    if user.getErrors()
      @getErrorsEl().html('Errors: ' + user.getErrors().toString())
    else
      @getErrorsEl().html('')

  onClickRegistration: (event) ->
    console.log('onClickRegistration', event)
    event.preventDefault()
    console.log("the model is ", @model)
    @model.register()
    Backbone.Mediator.pub('render:login')

  onRegistrationError: (event) ->
    console.log('onRegistrationError', event)

  onRegistrationSuccess: (event) ->
    console.log('onRegistrationSuccess', event)

  render: ->
    console.log("in here")
    $(@el).html(@template())


