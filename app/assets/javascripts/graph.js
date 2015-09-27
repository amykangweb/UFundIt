$(document).ready(function() {
  goal = $("#graph").data("goal");
  current = $("#graph").data("users");
  chart = d3.select("#graph")
    .append("svg")
    .attr("width", 415)
    .attr("height", 20);

    chart.append("rect")
    .attr("height", 20)
    .attr("width", (current/goal) * 415)
    .style("fill", "#B4656F");
});
