$(function(){

function flotData(w,y){
  var plot = $.plot($("#flot-color"), [{
          data: w,
		  label: '<a href="javascript:" class="type-btn-w">窗口门票</a>'
      },
	  {
          data: y,
		  label: '<a href="javascript:" class="type-btn-y">优联门票</a>'
      }], 
      {
        series: {
            lines: {
                show: true,
                lineWidth: 1,
                fill: true,
                fillColor: {
                    colors: [{
                        opacity: 0.0
                    }, {
                        opacity: 0.2
                    }]
                }
            },
            points: {
                radius: 5,
                show: true
            },
            shadowSize: 2
        },
        grid: {
            color: "#000",
            hoverable: true,
            clickable: true,
            tickColor: "#f0f0f0",
            borderWidth: 0
        },
        colors: ["#3fcf7f","#5191D1"],
        xaxis: {
            mode: "categories",
            tickDecimals: 0            
        },
        yaxis: {
            ticks: 5,
            tickDecimals: 0,            
        },
        tooltip: true,
        tooltipOpts: {
          content: "%x.1点售出%y.4张票",
          defaultTheme: false,
          shifts: {
            x: 0,
            y: 20
          }
        }
      }
  )
}


});