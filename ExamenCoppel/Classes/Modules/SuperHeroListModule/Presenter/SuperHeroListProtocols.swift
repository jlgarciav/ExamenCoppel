//
//  SuperHeroListProtocols.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

protocol SuperHeroListViewToPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: SuperHeroListPresenterToViewProtocol? {get set}
    var interactor: SuperHeroListPresenterToInteractorProtocol? {get set}
    var router: SuperHeroListPresenterToRouterProtocol? {get set}
    
    func showSuperHeroDetailController(myHero: SuperHero?)
    func viewDidLoad()
    func refresh()
    
    func numberOfRowsInSection() -> Int    
    func didSelectRowAt(index: Int)
    func getHeroAtRow(index: Int) -> SuperHero
    func searchHeroesByFilter(filter: String) -> [SuperHero]
}

protocol SuperHeroListPresenterToViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: SuperHeroListViewToPresenterProtocol? {get set}
    
    func onFetchSuperHeroSuccess()
    func onFetchSuperHeroFailure()
    
    func showLoading()
    func hideLoading()
}

protocol SuperHeroListPresenterToRouterProtocol: class {
    // PRESENTER -> ROUTER
    func showSuperHeroList() -> UIViewController
    func presentSuperHeroDetailModule(myHero: SuperHero?,from view: SuperHeroListPresenterToViewProtocol)
}

protocol SuperHeroListPresenterToInteractorProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: SuperHeroListInteractorToPresenterProtocol? {get set}
    
    func getSuperHeroByName()
}

protocol SuperHeroListInteractorToPresenterProtocol: class {
    // INTERACTOR -> PRESENTER
    func requestSuperHeroListSuccess(superheroList: [SuperHero] )
    func requestSuperHeroListFailure(superheroError: SuperHeroResponse)
}
