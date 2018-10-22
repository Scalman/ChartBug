//
//  ChartRouter.swift
//  Dashboard
//
//  Created by Waleed Hassan on 2018-04-08.
//  Copyright (c) 2018 Waleed Hassan. All rights reserved.

import UIKit

class ChartRouter: ChartRouterProtocol {
    weak var viewController: UIViewController?
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Chart", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "ChartsNavigationController") as? UINavigationController else{
            print("Couldn't find ChartsViewController, NavigationController")
            return UIViewController()
        }
        guard let view = storyboard.instantiateViewController(withIdentifier: "ChartViewController") as? ChartViewController else{
            return UIViewController()
        }
        
        //Remove navigationbar border
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        let interactor:ChartInteractorInputProtocol & ChartRemoteDataManagerOutputProtocol & ChartLocalDataManagerOutputProtocol = ChartInteractor()
        let router = ChartRouter()
        let presenter: ChartPresenterProtocol & ChartInteractorOutputProtocol = ChartPresenter()
        let remoteDataManager: ChartRemoteDataManagerInputProtocol = ChartRemoteDataManager()
        let localDataManager: ChartLocalDataManagerInputProtocol = ChartLocalDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.remoteRequestHandler = interactor
        localDataManager.localRequestHandler = interactor
        router.viewController = view
        
        //return view
        return navigationController
    }
    
    static func onError(message: String) {
        print(message)
    }
}
