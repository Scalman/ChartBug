//
//  ChartPresenter.swift
//  Dashboard
//
//  Created by Waleed Hassan on 2018-04-08.
//  Copyright (c) 2018 Waleed Hassan. All rights reserved.

import Foundation

class ChartPresenter: ChartPresenterProtocol {
    
    var view: ChartViewProtocol?
    var interactor: ChartInteractorInputProtocol?
    var router: ChartRouterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func onError(message: String) {
        view?.onError(message: message)
    }

}
extension ChartPresenter: ChartInteractorOutputProtocol {
    
}

