//
//  StackedBarChartView.swift
//  Dashboard
//
//  Created by Gustaf Holmström on 2018-04-15.
//  Copyright © 2018 Waleed Hassan. All rights reserved.
//

import UIKit
import Charts

class StackedChartView: BarChartView {
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " h"
        formatter.positiveSuffix = " h"
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
    
    public func defaultSetup(){
        isUserInteractionEnabled = true
        self.pinchZoomEnabled = false
        scaleXEnabled = false
        scaleYEnabled = false
        drawGridBackgroundEnabled = false
        drawBarShadowEnabled = false
        drawValueAboveBarEnabled = false
        drawBordersEnabled = false
        drawMarkers = false
        legend.enabled = true
        drawBordersEnabled = false
        leftAxis.drawTopYLabelEntryEnabled = true
        leftAxis.drawAxisLineEnabled = false
        rightAxis.drawLabelsEnabled = false
        rightAxis.enabled = false
        leftAxis.drawLabelsEnabled = false
        leftAxis.enabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true
        chartDescription?.text = "DIS IS CHART DESCRIPTION. IT IS VERY BEAUTIFUL!"
        highlightFullBarEnabled = false
    }
    
    public func emptyChart(text:String){
        self.noDataText = text
    }

    public func drawChart(values:[WorkDay],titles:[String]){
        self.noDataText = "No data available"
        
        let count:Int = values.count
        
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            
            let data = values[i].shifts!
            
            var shiftHours = [Double]()
            
            for shift in data{
                shiftHours.append(shift.hours!)
            }
            return BarChartDataEntry(x: Double(i), yValues: shiftHours, data: data as AnyObject)
        }
        
        let set = BarChartDataSet(values: yVals, label: "Stapeldiagram för dina pass denna vecka.")
        set.drawIconsEnabled = false
        set.colors = [ChartColorTemplates.material()[0], ChartColorTemplates.material()[1], ChartColorTemplates.material()[2]]
        set.stackLabels = ["Arbetade", "Lunch", "Missade"]
        
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueTextColor(.white)
        
        
        self.fitBars = true
        self.data = data
        
        
        let labels = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        
        self.animate(xAxisDuration: 0, yAxisDuration: 1)
    }
}
