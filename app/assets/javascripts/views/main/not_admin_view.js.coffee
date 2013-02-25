Idt.Views.Main ||= {}

class Idt.Views.Main.NotAdminView extends Backbone.View
  template: JST['main/not_admin_view_template']

  render: ->
    @$el.html(@template())
    @

