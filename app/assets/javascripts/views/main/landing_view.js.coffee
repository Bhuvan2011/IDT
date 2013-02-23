Idt.Views.Main ||= {}

class Idt.Views.Main.LandingView extends Backbone.View
  template: JST['main/landing_view_template']

  events:
    'click #login_button': 'onClickLoginButton'
    'click #registration_button': 'onClickRegistrationButton'

  initialize: ->
    @model = new Idt.Models.Main()
    @registrationView = new Idt.Views.Main.RegistrationView(model: @model.getCurrentUser())
    @loginView = new Idt.Views.Main.LoginView(model: @model.getCurrentUser())
   

  # Event Handlers:

  onClickRegistrationButton: ->
    $('#container').html(@registrationView.render())

  onClickLoginButton: ->
    $('#container').html(@loginView.render())

  render: ->
    @$el.html(@template())
    @
