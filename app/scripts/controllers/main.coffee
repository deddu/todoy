'use strict'

angular.module('todoyApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.appointments = []

    toDegrees=(rad)->
      return 360*(rad/(2.0*Math.PI))
      #+ 180

    toTime=(p)->
      starttime = if $scope.starttime? then $scope.starttime else 8
      time= toDegrees(p.t + Math.PI/2)
      step=1
      excess=time-Math.floor(time)
      spareh=0
      mm=(Math.round((60/step)*excess)*step)%60
      hh=Math.floor(time/30)%12
      hh= if hh<starttime then hh+12 else hh
      return {hh:hh,mm:mm}

    #now draw each in the list
    $scope.addPie = (pie) ->
      pie.i.start=toTime(pie.i)
      pie.e.end=toTime(pie.e)
      $scope.appointments.push(pie)
      console.log JSON.stringify($scope.appointments)

    #1: now for appointment in appointments we draw one;
    #2: on click we create a new entry
    #3: on save we post to rest
    #4: delete - update - etc etc