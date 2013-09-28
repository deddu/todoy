'use strict'

angular.module('todoyApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.draw = () ->
      console.log "drawing"
      c=document.getElementById "mycanvas"
      ctx=c.getContext "2d"
      ctx.beginPath()
      ctx.arc(100,75,50,0,2*Math.PI)
      ctx.stroke()
