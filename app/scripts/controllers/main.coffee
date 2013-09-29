'use strict'

angular.module('todoyApp')
  .controller 'MainCtrl', ($scope) ->
    #FIXME: this should be a directive (?)

    rad=(x)-> #convert to radians
      (x/360.0)*2*Math.PI
    $scope.rad = rad #exporting to scope to test since I'm lazy

    o={x:400,y:300} #fixing origin coordinates once for all

    theta = (p,r) -> # get the angle from the point - r is the distance from the origin
      #we have four quadrants to consider here...
      #1,1:
      if p.x > 0 and p.y>0
        return Math.asin(p.y/r)
      #-1,1:
      else if p.x <= 0 and p.y>0
        return Math.acos(p.x/r)
      #-1,-1:
      else if p.x <= 0 and p.y<=0
        return 2*Math.PI-Math.acos(p.x/r)
      #1,-1:
      else if p.x > 0 and p.y<0
        return Math.asin(p.y/r)

    $scope.theta=theta

    distFromO = (p) -> #get the distance from the origin, i.e. the radial coordinate
      r= Math.sqrt(Math.pow((p.x),2) + Math.pow((p.y),2))
    $scope.distFromO = distFromO

    addRadCoords = (p)->
      r=distFromO(p)
      t=theta(p,r)
      q={x:p.x, y:p.y, r:r, t:t}
      return q

    drawShit = (p1,p2) ->
      c=document.getElementById "mycanvas"
      ctx=c.getContext "2d"
      ctx.clearRect(0,0,800,600)#clear previous
      ctx.beginPath()
      cwise = false#if p1.t - p2.t >0 then true else false
      ctx.arc(o.x,o.y,p1.r,p1.t,p2.t,cwise )
      ctx.lineWidth =10
      ctx.stroke()
#      ctx.fill()

    drawing=false
    pie={i:o, e:o}

    getCoords = (evt) ->
      #FIXME: damn you firefox
      x = (if evt.offsetX? then evt.offsetX else evt.layerX) - o.x
      y = (if evt.offsetY? then evt.offsetY else evt.layerY) - o.y
      return {x:x, y:y}

    $scope.startEv = (evt) ->
      drawing=true
      pie.i=addRadCoords(getCoords(evt))

    $scope.doEv = (evt) ->
      if (drawing)
        p1=addRadCoords(getCoords(evt))
        drawShit(pie.i,p1)

    $scope.stopEv = (evt) ->
      drawing=false
      pie.e=addRadCoords(getCoords(evt))
      drawShit(pie.i,pie.e)
