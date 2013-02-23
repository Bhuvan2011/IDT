Idt.Views.Main ||= {}

class Idt.Views.Main.UsersView extends Backbone.View
  template: JST['main/users_view_template']
 
  render: ->
    $(@el).html(@template(users: @collection.models))
    @


 
