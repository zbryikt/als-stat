// Generated by LiveScript 1.2.0
var main;
main = function($scope, $http){
  var ref$, w, h, m, ctx, color;
  ref$ = [$(window).width(), $(window).height(), 60], w = ref$[0], h = ref$[1], m = ref$[2];
  $('#chart').attr({
    width: w - m * 2,
    height: h - m * 3
  });
  ctx = $('#chart')[0].getContext('2d');
  $scope.color = color = d3.scale.category20();
  $scope.chart = new Chart(ctx);
  $scope.load = function(){
    return $http({
      url: 'donate-group.json',
      method: 'GET'
    }).success(function(d){
      var labels, i$, y, j$, m, datasets, i, ref$, ret;
      $scope.data = d;
      labels = [];
      for (i$ = 2007; i$ <= 2014; ++i$) {
        y = i$;
        for (j$ = 1; j$ <= 12; ++j$) {
          m = j$;
          labels = labels.concat([y + "/" + (m > 9 ? '' : '0') + m]);
        }
      }
      labels = ["2006/12"].concat(labels);
      datasets = [{
        data: [],
        label: "捐款金額"
      }];
      for (i$ = 0; i$ < 96; ++i$) {
        i = i$;
        (ref$ = datasets[0]).data = ref$.data.concat([d[i] || 0]);
      }
      ret = {
        labels: labels,
        datasets: datasets
      };
      console.log(ret);
      return $scope.chart.Line(ret, {
        bezierCurveTension: 0.2,
        animation: false,
        datasetFill: false,
        multiTooltipTemplate: "<%= datasetLabel %> - <%= value %>"
      });
    }).error(function(e){});
  };
  return $scope.load();
};