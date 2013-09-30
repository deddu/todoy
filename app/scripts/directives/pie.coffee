'use strict';
angular.module('todoyApp')
  .directive('pie', () ->
    template: '<div></div>'
#    restrict: 'C'
    link: (scope, element, attrs) ->
      o={x:400,y:300}
      pie={i:o, e:o}
      drawing=false
      rad=(x)-> #convert to radians
        (x/360.0)*2*Math.PI

      theta = (p,r) -> # get the angle from the point - r is the distance from the origin
          #we have four quadrants to consider here...
        if p.x > 0 and p.y>0 #1,1:
          return Math.asin(p.y/r)
        else if p.x <= 0 and p.y>0 #-1,1:
          return Math.acos(p.x/r)
        else if p.x <= 0 and p.y<=0 #-1,-1:
          return Math.PI+Math.asin(-p.y/r)
        else if p.x > 0 and p.y<0 #1,-1:
          return 2*Math.PI-Math.acos(p.x/r)

      distFromO = (p) -> #get the distance from the origin, i.e. the radial coordinate
        r= Math.sqrt(Math.pow((p.x),2) + Math.pow((p.y),2))

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
        cwise = false
        ctx.fillText(JSON.stringify(p2), o.x, o.y)
        ctx.arc(o.x,o.y,p1.r,p1.t,p2.t,cwise )
        ctx.lineWidth =10
        ctx.stroke()

      getCoords = (evt) ->
        #FIXME: damn you firefox
        x = (if evt.offsetX? then evt.offsetX else evt.layerX) - o.x
        y = (if evt.offsetY? then evt.offsetY else evt.layerY) - o.y
        return {x:x, y:y}

      #      element.text 'this is the pie directive'
      element.bind 'mousedown',($event)->
        drawing=true
        pie.i=addRadCoords(getCoords($event))

      element.bind 'mousemove',($event)->
        if (drawing)
          p1=addRadCoords(getCoords($event))
          drawShit(pie.i,p1)

      element.bind 'mouseup',($event)->
        drawing=false
        pie.e=addRadCoords(getCoords($event))
        drawShit(pie.i,pie.e)
        scope.$apply (self)->
          self[attrs.pie](pie)
  )