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
  epsilon=  10e-5
  it 'converts 360 to 2pi', () ->
    expect(scope.rad(360)).toBeCloseTo(Math.PI *2, epsilon)
  it 'converts 90 to pi/2', () ->
    expect(scope.rad(90)).toBeCloseTo(Math.PI/2, epsilon)
  it 'converts -90 to pi/2', () ->
    expect(scope.rad(90)).toBeCloseTo(Math.PI/2, epsilon)
  it 'converts 270 and to pi/2', () ->
    expect(scope.rad(270)).toBeCloseTo(3*Math.PI/2, epsilon)
  it 'is capable of computing distances', () ->
    expect(scope.distFromO({x:1,y:1})).toBeCloseTo(Math.sqrt(2),epsilon)
  it 'is capable of computing distances', () ->
    expect(scope.distFromO({x:1,y:-1})).toBeCloseTo(Math.sqrt(2),epsilon)
  it 'is also capable of computing angles', () ->
    expect(scope.theta(1,Math.sqrt(2))).toBeCloseTo( Math.PI/4.0, epsilon)
  it 'is also capable of computing angles', () ->
    expect(scope.theta(10,10*Math.sqrt(2))).toBeCloseTo( Math.PI/4.0, epsilon)
#  it 'converts the point 100,100 to ', () ->
#    console.log scope
#    expect(scope.theta(1,Math.sqrt(2))).toBeCloseTo( Math.PI/4.0, epsilon)
