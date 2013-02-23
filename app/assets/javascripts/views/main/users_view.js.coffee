Idt.Views.Main ||= {}

class Idt.Views.Main.UsersView extends Backbone.View
  template: JST['main/users_view_template']
  template1: JST['main/add_user_view_template'] 
  

  events:
    'click .delete-user' : 'onClickDeleteUser'
    'click .add-user-button' : 'onClickAddUserButton'    
    'click .add-user' : 'onClickAddButton'
    'change #first_name': 'onChangeFirstName'
    'change #last_name': 'onChangeLastName'
    'change #user_name': 'onChangeUserName'
    'change #email': 'onChangeEmail'


  initialize: ->
    @addUserView = new Idt.Views.Main.AddUserView()
    @model = new Idt.Models.User()
    @model.bind('change:first_name', @onChangeModelFirstName, @)
    @model.bind('change:last_name', @onChangeModelLastName, @)
    @model.bind('change:user_name', @onChangeModelUserName, @)
    @model.bind('change:email', @onChangeModelEmail, @)
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('remove', @render, @)

  # Properties :
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


  # Event Handlers:

  onChangeFirstName:(event) ->
    @model.setFirstName(event.currentTarget.value)

  onChangeLastName:(event) ->
    @model.setLastName(event.currentTarget.value)

  onChangeUserName:(event) ->
    @model.setUserName(event.currentTarget.value)

  onChangeEmail:(event) ->
    @model.setEmail(event.currentTarget.value)

  onChangeModelFirstName: (model) ->
    @setFirstName(model.getFirstName())

  onChangeModelLastName: (model) ->
    @setLastName(model.getLastName())

  onChangeModelUserName: (model) ->
    @setUserName(model.getUserName())

  onChangeModelEmail: (model) ->
    @setEmail(model.getEmail()) 

  onClickAddButton: ->
    @model.save(null, success: @onSaveUser)

  onSaveUser:(model) =>
    @collection.add(model.clone(), at: 0)
    model.clear()
  

  onClickAddUserButton: ->
    console.log("add user")
    @$el.html(@template1())

  onClickDeleteUser: (event) ->
    id = event.currentTarget.dataset['userId']
    @deleteUser(id)

  # Methods :

  deleteUser: (id) ->
    user = @collection.get(id)
    @collection.remove(user)
    ajax = $.ajax(
      type: "DELETE"
      url: "http://localhost:3000/users/#{user.id}"
      data: {}
    )
    ajax.fail => alert "request failed"
    ajax.success (user) =>

  render: ->
    $(@el).html(@template(users: @collection.models))
    @$el.find('#products').dataTable()
    @ 
