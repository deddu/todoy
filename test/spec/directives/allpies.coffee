'use strict'

describe 'Directive: allpies', () ->

  # load the directive's module
  beforeEach module 'todoyApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<allpies></allpies>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the allpies directive'
