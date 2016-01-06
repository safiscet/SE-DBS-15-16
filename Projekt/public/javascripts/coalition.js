function createCoalitionDiagram(dataset, results){
  var margin = {top : 20, right : 20, bottom : 30, left : 40},
  outerWidth = 780,
  outerHeight = 500,
  width = outerWidth - margin.left - margin.right,
  height = outerHeight - margin.top - margin.bottom,
  xAxisTextMargin = 40;

  var maxSeats = 0;
  for(var i = 0; i < results.length; i++){
    maxSeats += parseInt(results[i].seats);
  }
  var halfseats = parseInt(maxSeats / 2);

  var x = d3.scale.ordinal()
  .rangeRoundBands([0, width], .1);

  var y = d3.scale.linear()
  .rangeRound([height - xAxisTextMargin, 0]);

  var xAxis = d3.svg.axis().scale(x).orient("bottom");
  var yAxis = d3.svg.axis().scale(y).orient("left").tickFormat(d3.format(".2s"));

  var svg = d3.select(".coalitions").append("svg")
  .attr("width", outerWidth)
  .attr("height", outerHeight)
  .append("g")
  .attr("transform", "translate(" + margin.left + ", " + margin.top + ")");

  dataset.forEach(function(d) {
    var y0 = 0;
    for(var i = 0; i < d.parties.length; i++){
      d.parties[i].y0 = y0;
      d.parties[i].y1 = y0 + parseInt(d.parties[i].seats);
      y0 = d.parties[i].y1;
    }
  });

  x.domain(dataset.map(function(d) { return d.name }));

  y.domain([0, maxSeats]);

  svg.append("g")
  .attr("class", "x axis")
  .attr("transform", "translate(0, " + (height - xAxisTextMargin) + ")")
  .call(xAxis)
  .selectAll("text")
  .call(function(t){
    t.each(function(d){ // for each one
      var self = d3.select(this);
      var s = self.text().split(', ');  // get the text and split it
      self.text(''); // clear it out
      for(var i = 0; i < s.length ; i++){
        self.append("tspan")
        .attr("x", 0)
        .attr("dy", "1.2em")
        .text(s[i]);
      }
    })
  });

  svg.append("g")
  .attr("class", "y axis")
  .call(yAxis)
  .append("text")
  .attr("transform", "rotate(-90)")
  .attr("y", 3)
  .attr("dy", ".71em")
  .style("text-anchor", "end")
  .text("Anzahl Sitze");

  var coalition = svg.selectAll(".coalition")
  .data(dataset)
  .enter().append("g")
  .attr("class", "g")
  .attr("transform", function(d) { return "translate(" + x(d.name) + ",0)"; });

  coalition.selectAll("rect")
  .data(function(d) { return d.parties })
  .enter().append("rect")
  .attr("width", x.rangeBand())
  .attr("y", function(d) { return y(d.y1); })
  .attr("height", function(d) { return y(d.y0) - y(d.y1); })
  .attr("fill", function(d) { return d.color; });

  svg.append("line")
    .attr("x1", -20)
    .attr("x2", width+20)
    .attr("y1", y(halfseats))
    .attr("y2", y(halfseats))
    .style("stroke-dasharray", ("5, 5"))
    .style("stroke-width", "2")
    .style("stroke", "#333");
}
