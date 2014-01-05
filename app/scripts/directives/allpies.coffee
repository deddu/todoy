'use strict';

angular.module('todoyApp')
  .directive('allpies', () ->
    template: '<div></div>'
    require:'pie'
    restrict:'E'
    link: (scope, element, attrs, pieCtrl) ->
      element.bind 'mouseenter',($event)->
        console.log "here"
        for appo in scope.appointments
          pieCtrl.drawShit(appo.i, appo.e)

  )
