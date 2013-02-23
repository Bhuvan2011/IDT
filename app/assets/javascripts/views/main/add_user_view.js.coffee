Idt.Views.Main ||= {}

class Idt.Views.Main.AddUserView extends Backbone.View
  template: JST['main/add_user_view_template']

  events: ->
    'click #add_button' : 'onClickAddButton'
    'change #first_name': 'onChangeFirstName'
    'change #last_name': 'onChangeLastName'
    'change #user_name': 'onChangeUserName'
    'change #email': 'onChangeEmail'
    'change #password': 'onChangePassword'
    'change #password_confirmation': 'onChangePasswordConfirmation'
    
  initialize: ->
    console.log('initialize the add user form view')
    @model = new Idt.Models.User()
    @model.bind('change:first_name', @onChangeModelFirstName, @)
    @model.bind('change:last_name', @onChangeModelLastName, @)
    @model.bind('change:user_name', @onChangeModelUserName, @)
    @model.bind('change:email', @onChangeModelEmail, @)
    @model.bind('change:password', @onChangeModelPassword, @)
    @model.bind('change:password_confirmation', @onChangeModelPawwordConfirmation, @)
 
  # Properties:

  getFirstNameInputEl: ->
    @$el.find('#first_name')

  setFirstName: (first_name) ->
    first_name = "" if typeof first_name is "undefined"
    @getFirstNameInputEl()[0].value = first_name
  

  # Events : 

  onChangeFirstName:(event) ->
    @model.setFirstName(event.currentTarget.value)

  onChangeLastName:(event) ->
    @model.setLastName(event.currentTarget.value)

  onChangeUserName:(event) ->
    @model.setUserName(event.currentTarget.value)

  onChangeEmail:(event) ->
    @model.setEmail(event.currentTarget.value)

  onChangePassword:(event) ->
    @model.setPassword(event.currentTarget.value)

  onChangePasswordConfirmation:(event) ->
    @model.setPasswordConfirmation(event.currentTarget.value)

  onChangeModelFirstName: (model) ->
    @setFirstName(model.getFirstName())

  onChangeModelLastName: (model) ->
    @setLastName(model.getLastName())

  onChangeModelUserName: (model) ->
    @setUserName(model.getUserName())

  onChangeModelEmail: (model) ->
    @setEmail(model.getEmail())

  onChangeModelPassword: (model) ->
    @setPassword(model.getPassword())

  onChangeModelPasswordConfirmation: (model) ->
    @setPasswordConfirmation(model.getPasswordConfirmation())

   
  onClickAddButton: ->
    @model.save(null, success: @onSaveUser)

  onSaveUser:(model) =>
    #@collection.add(model.clone(), at: 0)
    model.clear()

  render: ->
    @$el.html(@template())
    @


