main = ($scope, $http) ->
  [w,h,m] = [$(window)width!, $(window)height!, 60]

  $('#chart1').attr do
    width: w - m * 2
    height: h - m * 3
  ctx1 = $('#chart1').0.getContext \2d
  $scope.chart1 = new Chart(ctx1)

  $('#chart2').attr do
    width: w - m * 2
    height: h - m * 3
  ctx2 = $('#chart2').0.getContext \2d
  $scope.chart2 = new Chart(ctx2)

  $scope.color = color = d3.scale.category20!

  $scope.load = ->

    $http do
      url: \donate-group.json
      method: \GET
    .success (d) ->
      $scope.data = d
      labels = []
      for y from 2007 to 2014
        for m from 1 to 12
          labels ++= ["#y/#{if m > 9 => '' else '0'}#{m}"]
          if m == 8 and y == 2014 => break
        if m == 8 and y == 2014 => break
      labels = ["2006/12"] ++ labels
      datasets = [{data:[], label: "捐款金額",strokeColor: "rgba(255,0,0,1)",pointColor: "rgba(0,0,0,0.5)",pointStrokeColor:"rgba(0,0,0,0.9)"}]
      for i from 0 til 96
        if i >= labels.length => break
        datasets.0.data ++= [d[i] or 0]
      ret = {labels, datasets}
      console.log ret
      $scope.chart1.Line ret, do
        bezierCurveTension: 0.2
        animation: false
        datasetFill: false
        multiTooltipTemplate:"<%= datasetLabel %> - <%= value %>"
    .error (e) ->

    $http do
      url: \donate-group2.json
      method: \GET
    .success (data) ->
      $scope.data = data
      labels = []
      for m from 6 to 8
        for d from 1 to 31
          if m == 6 and d == 31 => break
          labels ++= ["#m/#d"]
      labels = ["05/31"] ++ labels
      datasets = [{data:[], label: "捐款金額",strokeColor: "rgba(255,0,0,1)",pointColor: "rgba(0,0,0,0.5)",pointStrokeColor:"rgba(0,0,0,0.9)"}]
      for i from 0 til 83
        datasets.0.data ++= [data[i] or 0]
      ret = {labels, datasets}
      $scope.chart2.Line ret, do
        bezierCurveTension: 0.2
        animation: false
        datasetFill: false
        multiTooltipTemplate:"<%= datasetLabel %> - <%= value %>"
    .error (e) ->

  $scope.load!
