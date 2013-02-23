Idt.Views.Main ||= {}

class Idt.Views.Main.UsersView extends Backbone.View
  template: JST['main/users_view_template']

  events:
    'click .delete-user' : 'onClickDeleteUser'
    'click .add-user' : 'onClickAddUser'

  initialize: ->
    @addUserView = new Idt.Views.Main.AddUserView()
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('remove', @render, @)

  # Event Handlers:

  onClickAddUser: ->
    console.log("add user")
    @$el.html(@addUserView.render().el)

  onClickDeleteUser: (event) ->
    id = event.currentTarget.dataset['userId']
    @deleteUser(id)

  # Properties :

  deleteUser: (id) ->
    console.log("********")
    console.log("the id is", id)
    console.log("collection is ", @collection)
    user = @collection.get(id)
    user.destroy(success: @onSuccessUserDestroy)

  onSuccessUserDestroy: (model, resp) =>
    @collection.remove(model)

  render: ->
    $(@el).html(@template(users: @collection.models))
    @$el.find('#products').dataTable()
    @


 
