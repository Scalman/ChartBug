//
//  ChartViewController.swift
//  Dashboard
//
//  Created by Waleed Hassan on 2018-04-08.
//  Copyright (c) 2018 Waleed Hassan. All rights reserved.
import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {
    var presenter: ChartPresenterProtocol?
    
    
    @IBOutlet weak var container: UIView!
    
    
    
    var dataModel = ChartModel()
    var weekData = [WorkDay]()
    
    var selectedGraph: graphTypes = .stackedBarChart
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        weekData = dataModel.generateTestDat()
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        //let shifts = entry.data as! [Shift]
        
        container.isHidden = false
        //EditView.isHidden = false
        //descLabel.text = shifts[highlight.stackIndex].description!
        //timeLabel.text = String(describing: shifts[highlight.stackIndex].hours!)
        //startLabel.text = String(describing: shifts[highlight.stackIndex].startTime!)
        //endLabel.text = String(describing: shifts[highlight.stackIndex].endTime!)
        
        // TODO: Send values for TableViewController
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        container.isHidden = true
    }
    
    
    
}


extension ChartViewController: ChartViewProtocol {
    func onError(message: String) {
        print(message)
    }
}

extension ChartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekData.count // Detta är fel. Den tar bara 7 för en vecka har 7 dagar.
                              // Vi vill ha så att den tar en array utav
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphCell", for: indexPath)
        
        return cell
    }
    
    /// Fade in TextView at Cell bottom when new Cell is shown.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let graphView = cell.viewWithTag(1) as? StackedChartView else{
            print("Could not find view with tag")
            return
        }
        graphView.delegate = self
        graphView.drawChart(values: weekData, titles: ["", ""])
        
        guard let periodLabel = cell.viewWithTag(2) as? UILabel else{
            print("Could not find periodLabel")
            return
        }
        
        guard let tempTest = weekData[indexPath.row].date else{
            print("No date set!")
            periodLabel.text = "No date set!"
            return
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yy"
        periodLabel.text = "\(weekData[indexPath.row].WeekDay!) \(dateformatter.string(from: tempTest))" 
        
    }
    
    /// Decides the size of each cell. In this case full screen.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height:collectionView.bounds.height)
    }
    
}


