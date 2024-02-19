
var g = svg.append("g").attr("transform", "translate(70,0)");

var cluster = d3.cluster().size([height, width - 200]);

r2d3.onRender(function (data, svg, w, h, options) {
  var root = d3.hierarchy(data, function (d) {
    return d.children;
  });

  cluster(root);

  g.selectAll("path")
    .data(root.descendants().slice(1))
    .enter()
    .append("path")
    .attr("d", function (d) {
      return (
        "M" +
        d.y +
        "," +
        d.x +
        "C" +
        (d.parent.y + 50) +
        "," +
        d.x +
        " " +
        (d.parent.y + 150) +
        "," +
        d.parent.x +
        " " +
        d.parent.y +
        "," +
        d.parent.x
      );
    })
    .style("fill", "none")
    .attr("stroke", "#037971")
    .style("stroke-width", 3)
    .attr("marker-end", function (d) {
      // Add arrowhead marker only to the latest nodes
      return !d.children ? null : "url(#arrow)";
    }) // Add arrowhead marker
    .attr("transform", "translate(0, 0)");

  // Define the arrowhead marker
  svg
    .append("defs")
    .append("marker")
    .attr("id", "arrow")
    .attr("viewBox", "0 0 10 10")
    .attr("refX", 10) // Adjust the position of the arrowhead
    .attr("refY", 5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("stroke", "red")
    .attr("fill", "none")
    .attr("orient", "auto")
    .append("path")
    .attr("d", "M0,0 L10,5 L0,10");

  var node = g
    .selectAll("g")
    .data(root.descendants())
    .enter()
    .append("g")
    .attr("class", "node_wrapper")
    .attr("transform", function (d) {
      return "translate(" + d.y + "," + d.x + ")";
    });

  node
    .append("circle")
    .attr("r", function (d) {
      return d.depth === 0 ? 60 : 0; // Circle only for the first node
    })
    .style("fill", function (d) {
      return d.depth === 0 ? "#5547AC" : "#69b3a2"; // Red for the first node
    })
    .attr("stroke", "#037971")
    .attr("class", "node")
    .attr("d", function (d) {
      return d.data.name;
    })
    .on("click", function (d) {
        if(d.data.colname && d.data.colname == "level3") {
          Shiny.setInputValue(options, d.data.name.toString());
        }
    });

  node
    .filter(function (d) {
      return d.depth > 0; // Last nodes only (excluding the root and nodes with children)
    })
    .append("rect")
    .attr("width", 200)
    .attr("height", 35)
    .attr("x", -70)
    .attr("y", -14)
    .style("fill", function (d) {
      return d.depth > 1 ? "white" : "#037971";
    })
    .attr("rx", 8) // Border radius for x-axis
    .attr("ry", 8)
    .attr("stroke", "#037971")
    .attr("class", "node")
    .style("cursor", "pointer") // Add pointer cursor
    .on("click", function (d) {
        if(d.data.colname && d.data.colname == "level3") {
          Shiny.setInputValue(options, d.data.name.toString());
        }
    });

  node
    .filter(function (d) {
      return d.depth >= 0; // Last nodes only (excluding the root and nodes with children)
    })
    .append("text")
    .attr("dy", 0) // Adjust vertical position
    .style("text-anchor", "middle")
    .style("dominant-baseline", "middle")
    .text(function (d) {
      return d.data.name[0]; // Assuming 'name' is the property containing the node label
    })
    .style("fill", function (d) {
      return d.depth > 1 ? "#037971" : "white";
    })
    .style("cursor", "pointer")
    .style("font-size", "12px")
    .style("font-weight", "bold")
    .each(function (d) {
      // Dynamically calculate the width and height based on text content
      const textWidth = this.getBBox().width + 20; // Adding extra padding
      const textHeight = this.getBBox().height + 15; // Adding extra padding

      // Update the rectangle width and height
      d3.select(this.parentNode)
        .select("rect")
        .attr("width", textWidth)
        .attr("height", textHeight)
        .attr("x", -textWidth / 2) // Center the rectangle around the text
        .attr("y", -textHeight / 2);
    }).on("click", function (d) {
        if(d.data.colname && d.data.colname == "level3") {
          Shiny.setInputValue(options, d.data.name.toString());
        }
    });
});
