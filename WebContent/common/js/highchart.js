function setHCLine( chartAreaId, titleText, categoryData, chartData ) {

    Highcharts.chart(chartAreaId, {
        title: {
            text: titleText,
            x: -20 //center
        },
        xAxis: {
            categories: categoryData
        },
        yAxis: {
            title: {
                text: '개'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '개'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: chartData
    });
}

function setHCDonut( chartAreaId, titleText, chartData, isMobile ) {
	var yData = 0;
	if(isMobile) {
		yData = -20;
	}
	
    Highcharts.chart( chartAreaId, { // 
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: titleText, // ' 상태',
            align: 'center',
            verticalAlign: 'middle',
            y:yData
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.y}</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer', 
                dataLabels: {
                    enabled:(!isMobile),
                    format: '{point.name}', // '<b>{point.name}</b>: {point.percentage:.1f} %',
                    distance: -10,
                    x:-20,
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }, 
                showInLegend:(isMobile)
            }
        },
        series: [{
            name: '비율',
            colorByPoint: true,
            innerSize: '60%',
            size:"80%",
            data: chartData
        }]
    });
}

function setHCHalfCircle( chartAreaId, titleText, chartData, isMobile ) {
	var yData = 50;
	if(isMobile) {
		yData = 10;
	}
	
    Highcharts.chart( chartAreaId, {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: titleText,
            align: 'center',
            verticalAlign: 'middle',
            y:yData
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.y}</b>'
        },
        plotOptions: {
            pie: {
                dataLabels: {
                	enabled:(!isMobile),
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        fontWeight: 'bold',
                        color: 'white'
                    }
                },
                distance:1,
                showInLegend:(isMobile),
                startAngle: -90,
                endAngle: 90,
                center: ['50%', '75%']
            }
        },
        series: [{
            type: 'pie',
            name: '담보물 비율',
            innerSize: '60%',
            size:"90%",
            data: chartData
        }]
    });
}

var timeIdx = 0;
function setHCSPline( chartAreaId, titleText, chartData ) {
//    $(document).ready(function () {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });

        Highcharts.chart( chartAreaId, { // 
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function () {
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        var timer = setInterval(function () {
                            var x = (new Date()).getTime(), // current time
                                y = Math.random();
                            series.addPoint([x, y], true, true);
                            timeIdx++;
                            if( timeIdx > 20 ) clearInterval(timer);
                        }, 1000);
                    }
                }
            },
            title: {
                text: titleText
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'Value'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function () {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i += 1) {
                        data.push({
                            x: time + i * 1000,
                            y: chartData[i+19]
                        });
                    }
                    return data;
                }())
            }]
        });
//    });
}
/*
function setHCline( chartArea, jsonUrl ) {
	$.getJSON(jsonUrl, function (data) {
        var detailChart;

//        $(document).ready(function () {

            // create the detail chart
            function createDetail(masterChart) {

                // prepare the detail chart
                var detailData = [],
                    detailStart = data[0][0];

                $.each(masterChart.series[0].data, function () {
                    if (this.x >= detailStart) {
                        detailData.push(this.y);
                    }
                });

                // create a detail chart referenced by a global variable
                detailChart = Highcharts.chart('detail-container', {
                    chart: {
                        marginBottom: 120,
                        reflow: false,
                        marginLeft: 50,
                        marginRight: 20,
                        style: {
                            position: 'absolute'
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '신규 담보물'
                    },
                    subtitle: {
                        text: 'Select an area by dragging across the lower chart'
                    },
                    xAxis: {
                        type: 'datetime'
                    },
                    yAxis: {
                        title: {
                            text: null
                        },
                        maxZoom: 0.1
                    },
                    tooltip: {
                        formatter: function () {
                            var point = this.points[0];
                            return '<b>' + point.series.name + '</b><br/>' + Highcharts.dateFormat('%A %B %e %Y', this.x) + ':<br/>' +
                                '1 USD = ' + Highcharts.numberFormat(point.y, 2) + ' EUR';
                        },
                        shared: true
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            marker: {
                                enabled: false,
                                states: {
                                    hover: {
                                        enabled: true,
                                        radius: 3
                                    }
                                }
                            }
                        }
                    },
                    series: [{
                        name: 'USD to EUR',
                        pointStart: detailStart,
                        pointInterval: 24 * 3600 * 1000,
                        data: detailData
                    }],

                    exporting: {
                        enabled: false
                    }

                }); // return chart
            }

            // create the master chart
            function createMaster() {
                Highcharts.chart('master-container', {
                    chart: {
                        reflow: false,
                        borderWidth: 0,
                        backgroundColor: null,
                        marginLeft: 50,
                        marginRight: 20,
                        zoomType: 'x',
                        events: {

                            // listen to the selection event on the master chart to update the
                            // extremes of the detail chart
                            selection: function (event) {
                                var extremesObject = event.xAxis[0],
                                    min = extremesObject.min,
                                    max = extremesObject.max,
                                    detailData = [],
                                    xAxis = this.xAxis[0];

                                // reverse engineer the last part of the data
                                $.each(this.series[0].data, function () {
                                    if (this.x > min && this.x < max) {
                                        detailData.push([this.x, this.y]);
                                    }
                                });

                                // move the plot bands to reflect the new detail span
                                xAxis.removePlotBand('mask-before');
                                xAxis.addPlotBand({
                                    id: 'mask-before',
                                    from: data[0][0],
                                    to: min,
                                    color: 'rgba(0, 0, 0, 0.2)'
                                });

                                xAxis.removePlotBand('mask-after');
                                xAxis.addPlotBand({
                                    id: 'mask-after',
                                    from: max,
                                    to: data[data.length - 1][0],
                                    color: 'rgba(0, 0, 0, 0.2)'
                                });


                                detailChart.series[0].setData(detailData);

                                return false;
                            }
                        }
                    },
                    title: {
                        text: null
                    },
                    xAxis: {
                        type: 'datetime',
                        showLastTickLabel: true,
                        maxZoom: 14 * 24 * 3600000, // fourteen days
                        plotBands: [{
                            id: 'mask-before',
                            from: data[0][0],
                            to: data[data.length - 1][0],
                            color: 'rgba(0, 0, 0, 0.2)'
                        }],
                        title: {
                            text: null
                        }
                    },
                    yAxis: {
                        gridLineWidth: 0,
                        labels: {
                            enabled: false
                        },
                        title: {
                            text: null
                        },
                        min: 0.6,
                        showFirstLabel: false
                    },
                    tooltip: {
                        formatter: function () {
                            return false;
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    credits: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            fillColor: {
                                linearGradient: [0, 0, 0, 70],
                                stops: [
                                    [0, Highcharts.getOptions().colors[0]],
                                    [1, 'rgba(255,255,255,0)']
                                ]
                            },
                            lineWidth: 1,
                            marker: {
                                enabled: false
                            },
                            shadow: false,
                            states: {
                                hover: {
                                    lineWidth: 1
                                }
                            },
                            enableMouseTracking: false
                        }
                    },

                    series: [{
                        type: 'area',
                        name: 'USD to EUR',
                        pointInterval: 24 * 3600 * 1000,
                        pointStart: data[0][0],
                        data: data
                    }],

                    exporting: {
                        enabled: false
                    }

                }, function (masterChart) {
                    createDetail(masterChart);
                }); // return chart instance
            }

            // make the container smaller and add a second container for the master chart
            var $container = $( chartArea ) // 
                .css('position', 'relative');

            $('<div id="detail-container">')
                .appendTo($container);

            $('<div id="master-container">')
                .css({
                    position: 'absolute',
                    top: 300,
                    height: 100,
                    width: '100%'
                })
                    .appendTo($container);

            // create master and in its callback, create the detail chart
            // createMaster();
            createDetail(); // 
        });
//    });
}
*/

function setHCColumn( chartAreaId, titleText, xData, chartData ) {
    Highcharts.chart(chartAreaId, {
        chart: {
            type: 'column'
        },
        title: {
            text: titleText
        },
        xAxis: {
            categories: xData
        },
        yAxis: {
            min: 0,
            title: {
                text: '담보물 등록 개수'
            },
            stackLabels: {
                enabled: true,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            }
        },
        legend: {
            align: 'right',
            x: -30,
            verticalAlign: 'top',
            y: 25,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
            borderColor: '#CCC',
            borderWidth: 1,
            shadow: false
        },
        tooltip: {
            headerFormat: '<b>{point.x}</b><br/>',
            pointFormat: '{series.name}: {point.y}<br/>등록: {point.stackTotal}'
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                dataLabels: {
                    enabled: true,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                }
            }
        },
        series: chartData
    });
}

function setHCPeriodLine( chartAreaId, titleText, xData, chartData ) {
//    $.getJSON(jsonUrl, function (data) {
// console.log(data)
        Highcharts.chart(chartAreaId, {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: titleText
            },
            xAxis: {
                categories: xData,
                labels: {enabled:false}
            },
            yAxis: {
                title: {
                    text: '가동률'
                }
                
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, Highcharts.getOptions().colors[0]],
                            [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },

            series: [{
                type: 'area',
                name: '가동률',
                data: chartData
            }]
        });
//    });
}