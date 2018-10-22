//
//  ChartInteractor.swift
//  Dashboard
//
//  Created by Waleed Hassan on 2018-04-08.
//  Copyright (c) 2018 Waleed Hassan. All rights reserved.

import Foundation

class ChartInteractor: ChartInteractorInputProtocol {
    var presenter: ChartInteractorOutputProtocol?
    var remoteDataManager:ChartRemoteDataManagerInputProtocol?
    var localDataManager:ChartLocalDataManagerInputProtocol?

}

extension ChartInteractor: ChartRemoteDataManagerOutputProtocol {
    
    func onRemoteError(message:String) {
        presenter?.onError(message:message)
    }
}
extension ChartInteractor: ChartLocalDataManagerOutputProtocol {
    
    func onLocalError(message:String) {
        presenter?.onError(message:message)
    }
}
