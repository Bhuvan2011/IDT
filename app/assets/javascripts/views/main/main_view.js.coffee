Idt.Views.Main ||= {}

class Idt.Views.Main.MainView extends Backbone.View
  template: JST['main/main_view_template']
  

  initialize: ->
    console.log('initialize The Main View')
    #@model = new Idt.Models.Main()
    @landingView = new Idt.Views.Main.LandingView()
    #@registrationView = new Idt.Views.Main.RegistrationView(model: @model.getCurrentUser())
    #@loginView = new Idt.Views.Main.LoginView()
   
  
  render: ->
    console.log("rendering the main view")
    @landingView.render() 
    
    



