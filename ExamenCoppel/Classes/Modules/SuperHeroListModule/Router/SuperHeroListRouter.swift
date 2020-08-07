//
//  SuperHeroListRouter.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

public final class SuperHeroListRouter {
    public static let shared = SuperHeroListRouter()
}

extension SuperHeroListRouter: SuperHeroListPresenterToRouterProtocol {
    func showSuperHeroList() -> UIViewController {
        let view =  SuperHeroListView()
        
        // perform custom stuff
        let presenter: SuperHeroListViewToPresenterProtocol & SuperHeroListInteractorToPresenterProtocol = SuperHeroListPresenter()
        let router: SuperHeroListPresenterToRouterProtocol = SuperHeroListRouter()
        let interactor: SuperHeroListPresenterToInteractorProtocol = SuperHeroListInteractor()
        
        presenter.view = view as? SuperHeroListPresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
        
    }
    
    func presentSuperHeroDetailModule(myHero: SuperHero?, from view: SuperHeroListPresenterToViewProtocol) {
        let superheroDetailView =  SuperHeroDetailRouter.shared.showSuperHeroDetail(myHero: myHero)
        guard let currentView = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        currentView.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        currentView.navigationController?.pushViewController(superheroDetailView, animated: true)
    }
}
