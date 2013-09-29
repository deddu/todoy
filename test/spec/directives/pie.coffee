'use strict'

describe 'Directive: pie', () ->

  # load the directive's module
  beforeEach module 'todoyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pie></pie>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pie directive'
