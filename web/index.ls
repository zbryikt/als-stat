main = ($scope, $http) ->
  [w,h,m] = [$(window)width!, $(window)height!, 60]
  $('#chart').attr do
    width: w - m * 2
    height: h - m * 3
  ctx = $('#chart').0.getContext \2d
  $scope.color = color = d3.scale.category20!
  $scope.chart = new Chart(ctx)

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
      labels = ["2006/12"] ++ labels
      datasets = [{data:[], label: "捐款金額"}]
      for i from 0 til 96
        datasets.0.data ++= [d[i] or 0]
      ret = {labels, datasets}
      console.log ret
      $scope.chart.Line ret, do
        bezierCurveTension: 0.2
        animation: false
        datasetFill: false
        multiTooltipTemplate:"<%= datasetLabel %> - <%= value %>"
    .error (e) ->
  $scope.load!
