Idt.Views.Main ||= {}

class Idt.Views.Main.EditUserView extends Backbone.View
  template: JST['main/edit_user_view_template'] 

  events: ->
    'click .update' : 'onClickUpdateButton'
    'click .delete' : 'onClickDeleteButton'
    'change #first_name': 'onChangeFirstName'
    'change #last_name': 'onChangeLastName'
    'change #user_name': 'onChangeUserName'
    'change #email': 'onChangeEmail'
    
  initialize: ->
    console.log('initialize the add user form view')
    @model.bind('change:first_name', @onChangeModelFirstName, @)
    @model.bind('change:last_name', @onChangeModelLastName, @)
    @model.bind('change:user_name', @onChangeModelUserName, @)
    @model.bind('change:email', @onChangeModelEmail, @)
    @model.bind('change:roles', @onChangeModelRoles, @)
 
  # Properties:

  getFirstNameInputEl: ->
    @$el.find('#first_name')

  setFirstName: (first_name) ->
    first_name = "" if typeof first_name is "undefined"
    @getFirstNameInputEl()[0].value = first_name
 
  getLastNameInputEl: ->
    @$el.find('#last_name')

  setLastName: (last_name) ->
    last_name = "" if typeof last_name is "undefined"
    @getFirstNameInputEl()[0].value = last_name

  getUserNameInputEl: ->
    @$el.find('#user_name')

  setUserName: (user_name) ->
    user_name = "" if typeof user_name is "undefined"
    @getUserNameInputEl()[0].value = user_name
  
  getEmailInputEl: ->
    @$el.find('#email')

  setEmail: (email) ->
    email = "" if typeof email is "undefined"
    @getEmailInputEl()[0].value = email

  getRolesInputEl: ->
    @$el.find('#roles')

  setRoles: (roles) ->
    roles = "" if typeof roles is "undefined"
    @getEmailInputEl()[0].value = roles
  

  # Events : 
  #
  onChangeRoles: (event) ->
    @model.setRoles(event.currentTarget.value)

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

  onChangeModelRoles: (model) ->
    @setRoles(model.getRoles())

  onClickDeleteButton: (event) ->
    id = event.currentTarget.dataset['userId']
    Backbone.Mediator.pub('delete:user',id )    
  
  onClickUpdateButton: ->
    @model.update()
    Backbone.Mediator.pub('reset:collection')

  onSaveUser:(model) =>
    @collection.add(model.clone(), at: 0)
    model.clear()

  render: ->
    @$el.html(@template(model: @model.attributes))
    @


