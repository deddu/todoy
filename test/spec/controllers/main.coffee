'use strict'

describe 'Controller: MainCtrl', () ->

  # load the controller's module
  beforeEach module 'todoyApp'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'converts 360 to 2pi', () ->
    expect(scope.rad(360)).toBe Math.PI *2
