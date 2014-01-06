'use strict';
angular.module('todoyApp')
  .directive('pie', () ->
#    require:['^width','^height']
    template:
      """
          <canvas id='mycanvas' width='{{width}}' height='{{height}}'></canvas>
      """
    restrict: 'EC'

    controller: ($scope) ->
      @drawShit = (p1,p2,w,h) ->
        #w = width || 320
        #h = height || 320
        o = { x: Math.round(w/2), y: Math.round(h/2)}
        c=document.getElementById "mycanvas"
        ctx=c.getContext "2d"
        ctx.clearRect(0,0,w,h)#clear previous
        ctx.beginPath()
        cwise = false
        ctx.fillText(JSON.stringify(p2), o.x, o.y)
        ctx.arc(o.x, o.y, p1.r,p1.t,p2.t,cwise )
        ctx.lineWidth =10
        ctx.stroke()

      @rad=(x)-> #convert to radians
          (x/360.0)*2*Math.PI

      @theta = (p,r) -> # get the angle from the point - r is the distance from the origin
        #we have four quadrants to consider here...
        if p.x > 0 and p.y>0 #1,1:
          return Math.asin(p.y/r)
        else if p.x <= 0 and p.y>0 #-1,1:
          return Math.acos(p.x/r)
        else if p.x <= 0 and p.y<=0 #-1,-1:
          return Math.PI+Math.asin(-p.y/r)
        else if p.x > 0 and p.y<0 #1,-1:
          return 2*Math.PI-Math.acos(p.x/r)

      @distFromO = (p) -> #get the distance from the origin, i.e. the radial coordinate
        r= Math.sqrt(Math.pow((p.x),2) + Math.pow((p.y),2))

      @addRadCoords = (p)->
        r=@distFromO(p)
        t=@theta(p,r)
        q={x:p.x, y:p.y, r:r, t:t}
        return q



    link: (scope, element, attrs, pieCtrl) ->
      w=attrs.width
      h=attrs.height
      o={x:Math.round(w/2),y:Math.round(h/2)}
      pie={i:o, e:o}
      drawing=false

      getCoords = (evt) ->
        #FIXME: damn you firefox
        x = (if evt.offsetX? then evt.offsetX else evt.layerX) - o.x
        y = (if evt.offsetY? then evt.offsetY else evt.layerY) - o.y
        return {x:x, y:y}
      #      element.text 'this is the pie directive'
      element.bind 'mousedown',($event)->
        drawing=true
        pie.i=pieCtrl.addRadCoords(getCoords($event))

      element.bind 'mousemove',($event)->
        if (drawing)
          p1=pieCtrl.addRadCoords(getCoords($event))
          pieCtrl.drawShit(pie.i,p1, w,h)

      element.bind 'mouseup',($event)->
        drawing=false
        pie.e=pieCtrl.addRadCoords(getCoords($event))
        pieCtrl.drawShit(pie.i,pie.e, w,h)
        scope.width = w
        scope.height = h
        scope.$apply (self)->
          self[attrs.pie](pie)


  )