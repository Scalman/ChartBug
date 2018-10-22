//
//  ChartProtocols.swift
//  Dashboard
//
//  Created by Waleed Hassan on 2018-04-08.
//  Copyright (c) 2018 Waleed Hassan. All rights reserved.

import Foundation

//MARK: Wireframe -
protocol ChartRouterProtocol: class {
}

//MARK: View -
protocol ChartViewProtocol: class {
    var presenter: ChartPresenterProtocol?  { get set }
    
    func onError(message:String)
}

//MARK: Presenter -
protocol ChartPresenterProtocol: class {
    var view: ChartViewProtocol? {get set}
    var interactor: ChartInteractorInputProtocol? {get set}
    var router: ChartRouterProtocol? {get set}
    
    func viewDidLoad()
    func onError(message:String)
}

//MARK: Interactor  - Input
protocol ChartInteractorInputProtocol: class {
    var presenter: ChartInteractorOutputProtocol?  { get set }
    var remoteDataManager: ChartRemoteDataManagerInputProtocol? { get set }
    var localDataManager: ChartLocalDataManagerInputProtocol? { get set }

    /* Presenter -> Interactor */
}

//MARK: Interactor  - Output
protocol ChartInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func onError(message:String)
}

//MARK: DataManager  - Remote
protocol  ChartRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ChartRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
   
}

protocol  ChartRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRemoteError(message:String)
}


//MARK: DataManager  - Local
protocol  ChartLocalDataManagerInputProtocol: class {
    var localRequestHandler: ChartLocalDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    
}

protocol  ChartLocalDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onLocalError(message:String)
}
