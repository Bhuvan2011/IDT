Idt.Views.Main ||= {}

class Idt.Views.Main.RegistrationView extends Backbone.View
  template: JST['main/registration_view_template']

  events:
    'change #first_name': 'onChangeFirstName'
    'change #last_name':  'onChangeLastName'
    'change #email': 'onChangeEmail'
    'change #password': 'onChangePassword'
    'change #password_confirmation' : 'onChangePasswordConfirmation'
    'click  #registration_button': 'onClickRegistration'
    
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

  getPasswordEl: ->
    @$el.find('#password')

  getPasswordConfirmationEl: ->
    @$el.find('#password_confirmation')


  # View events:

  onChangeFirstName: (event) ->
    @model.setFirstName(event.currentTarget.value)

  onChangeLastName: (event) ->
    @model.setLastName(event.currentTarget.value)

  onChangeEmail: (event) ->
    @model.setEmail(event.currentTarget.value)

  onChangePassword: (event) ->
    @model.setPassword(event.currentTarget.value)

  onChangePasswordConfirmation: (event) ->
    @model.setPasswordConfirmation(event.currentTarget.value)

    
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

  onRegistrationError: (event) ->
    console.log('onRegistrationError', event)

  onRegistrationSuccess: (event) ->
    console.log('onRegistrationSuccess', event)

  render: ->
    console.log("in here")
    $(@el).html(@template())


