(($) ->
  #demo data
  contacts = [
    {
      name: 'Contact 1'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'family'
    }
    {
      name: 'Contact 2'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'family'
    }
    {
      name: 'Contact 3'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'friend'
    }
    {
      name: 'Contact 4'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'colleague'
    }
    {
      name: 'Contact 5'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'family'
    }
    {
      name: 'Contact 6'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'colleague'
    }
    {
      name: 'Contact 7'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'friend'
    }
    {
      name: 'Contact 8'
      address: '1, a street, a town, a city, AB12 3CD'
      tel: '0123456789'
      email: 'anemail@me.com'
      type: 'family'
    }
  ]
  #define product model
  Contact = Backbone.Model.extend(defaults: photo: '/img/placeholder.png')
  #define directory collection
  Directory = Backbone.Collection.extend(model: Contact)
  #define individual contact view
  ContactView = Backbone.View.extend(
    tagName: 'article'
    className: 'contact-container'
    template: $('#contactTemplate').html()
    render: ->
      tmpl = _.template(@template)
      $(@el).html tmpl(@model.toJSON())
      this
  )
  #define master view
  DirectoryView = Backbone.View.extend(
    el: $('#contacts')
    initialize: ->
      @collection = new Directory(contacts)
      @render()
      return
    render: ->
      that = this
      _.each @collection.models, ((item) ->
        that.renderContact item
        return
      ), this
      return
    renderContact: (item) ->
      contactView = new ContactView(model: item)
      @$el.append contactView.render().el
      return
  )
  #create instance of master view
  directory = new DirectoryView
  return
) jQuery