'use strict'

angular.module('todoyApp')
  .controller 'MainCtrl', ($scope) ->
    #FIXME: this should be a directive (?)
    $scope.drawPie = () ->
      pie=$scope.pie
      c=document.getElementById "mycanvas"
      ctx=c.getContext "2d"
      ctx.beginPath()
      ctx.arc(pie.x0,pie.y0,pie.r,rad(pie.t0),rad(pie.t1))
      ctx.stroke()
      ctx.fill()




    rad=(x)-> #convert to radians
      (x/360)*2*Math.PI
    $scope.rad = rad #exporting to scope to test since I'm lazy

    o={x:150,y:150} #fixing origin coordinates once for all

    theta = (x,r) -> # get the angle from the point - r is the distance from the origin
      Math.atan(x/r)

    distFromO = (p) -> #get the distance from the origin, i.e. the radial coordinate
      Math.sqrt(Math.pow((p.x - o.x),2) + Math.pow((p.y - o.y),2))

    toRadCoords = (p)->
      r=distFromO(p)
      t=theta(p.x,r)
      q={r:r,t:t}
      #console.log q

    drawShit = (p1,p2) ->
      c=document.getElementById "mycanvas"
      ctx=c.getContext "2d"
      ctx.clearRect(0,0,800,600)#clear previous
      ctx.beginPath()
      ctx.arc(o.x,o.y,p1.r,p1.t,p2.t)
      ctx.stroke()
      ctx.fill()

    $scope.doEv = (evt) ->
      console.log {x:evt.offsetX, y:evt.offsetY}
      p0=toRadCoords({x:evt.offsetX, y:evt.offsetY})
      console.log p0
      p1={r:0,t:0}#toRadCoords({x:evt.offsetX, y:evt.offsetY})
      drawShit(p0,p1)

    #what I want is :
    ###
    on click:
       radii = mouse.x - ox ^2 + mouse.y - oy ^2 #where ox,oy is the origin
       x0 = mouse.x
       y0 = mouse.y
    on drag
      arc between x1 y1, x0,y0 with rad x1origin and fill.

###