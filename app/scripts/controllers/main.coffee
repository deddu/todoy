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

    $scope.drawPie = () ->
      pie=$scope.pie
      console.log "drawing"
      c=document.getElementById "mycanvas"
      ctx=c.getContext "2d"
      ctx.beginPath()
      ctx.arc(pie.x0,pie.y0,pie.r,pie.t0*2*Math.PI,pie.t1*2*Math.PI)
      ctx.stroke()