//
//  SuperHeroDetailRouter.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

public final class SuperHeroDetailRouter {
    public static let shared = SuperHeroDetailRouter()
}

extension SuperHeroDetailRouter: SuperHeroDetailPresenterToRouterProtocol {
    func showSuperHeroDetail(myHero: SuperHero?) -> UIViewController {
        let view =  SuperHeroDetailView()
        
        // perform custom stuff
        let presenter: SuperHeroDetailViewToPresenterProtocol & SuperHeroDetailInteractorToPresenterProtocol = SuperHeroDetailPresenter()
        let router: SuperHeroDetailPresenterToRouterProtocol = SuperHeroDetailRouter()
        let interactor: SuperHeroDetailPresenterToInteractorProtocol = SuperHeroDetailInteractor()
        
        presenter.view = view as? SuperHeroDetailPresenterToViewProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
        view.myHero = myHero
        
        
        
        return view
        
    }
}
