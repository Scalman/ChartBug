//
//  ContentSelectionController.swift
//  Dashboard
//
//  Created by Gustaf Holmström on 2018-04-28.
//  Copyright © 2018 Waleed Hassan. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell{
    
    static let reuseIdentifier = String(describing: ContentCell.self)

    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView.backgroundColor = .lightGray
            } else {
                imageView.backgroundColor = .clear
            }
        }
    }
}

class ContentSelectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // INITIAL SELECTION
    var selectedGraph: graphTypes = .stackedBarChart
    
    /// Invoked when the `selectedVirtualContent` property changes.
    var selectionHandler: (graphTypes) -> Void = { _ in }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 292, height: 73)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let itemIndex = selectedGraph.rawValue
        let indexPath = IndexPath(item: itemIndex, section: 0)
        collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graphTypes.orderedValues.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.reuseIdentifier, for: indexPath) as? ContentCell else {
            fatalError("Expected `\(ContentCell.self)` type for reuseIdentifier \(ContentCell.reuseIdentifier). Check the configuration in Main.storyboard.")
        }
        
        let content = graphTypes(rawValue: indexPath.item)!
        
        
        // TODO: ändra så ingen ifsats är nödvänding och den tar bara bildens adress beroende på vad om är valt.
        if(content.graphName == "none"){
            cell.imageView?.image = #imageLiteral(resourceName: "none")
        }else if(content.graphName == "faceGeometry"){
            cell.imageView?.image = #imageLiteral(resourceName: "Cheep")
        }else if(content.graphName == "overlayModel"){
            cell.imageView?.image = #imageLiteral(resourceName: "Giraff")
        }else if(content.graphName == "blendShapeModel"){
            cell.imageView?.image = #imageLiteral(resourceName: "InfoDotThree")
        }else if(content.graphName == "stackedBarChart"){
            cell.imageView?.image = #imageLiteral(resourceName: "StackedChart")
        }else if(content.graphName == "pieChart"){
            cell.imageView?.image = #imageLiteral(resourceName: "PieChart")
        }
        
        //cell.imageView?.image = UIImage(named: content.imageName)
        cell.isSelected = indexPath.item == selectedGraph.rawValue
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGraph = graphTypes(rawValue: indexPath.item)!
        selectionHandler(selectedGraph)
        dismiss(animated: true, completion: nil)
    }
}

enum graphTypes: Int {
    case stackedBarChart
    case pieChart
    case none
    case faceGeometry
    case overlayModel
    case blendShapeModel
    
    static let orderedValues: [graphTypes] = [.stackedBarChart, .pieChart, .none, .faceGeometry, .overlayModel, .blendShapeModel]
    
    var graphName: String {
        switch self {
        case .stackedBarChart: return "stackedBarChart"
            case .pieChart: return "pieChart"
            case .none: return "none"
            case .faceGeometry: return "faceGeometry"
            case .overlayModel: return "overlayModel"
            case .blendShapeModel: return "blendShapeModel"
        }
    }
}

