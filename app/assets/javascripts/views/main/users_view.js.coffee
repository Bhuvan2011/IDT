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
    user = @collection.get(id)
    @collection.remove(user)
    ajax = $.ajax(
      type: "DELETE"
      url: "http://localhost:3000/users/#{user.id}"
      data: {}
    )
    ajax.fail => alert "request failed"
    ajax.success (user) =>
      alert "deleted"

  render: ->
    $(@el).html(@template(users: @collection.models))
    @$el.find('#products').dataTable()
    @


 
