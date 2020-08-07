//
//  SuperHeroDetailProtocols.swift
//  ExamenCoppel
//
//  Created by José Luis García on 06/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

protocol SuperHeroDetailViewToPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: SuperHeroDetailPresenterToViewProtocol? {get set}
    var interactor: SuperHeroDetailPresenterToInteractorProtocol? {get set}
    var router: SuperHeroDetailPresenterToRouterProtocol? {get set}
    
    func viewDidLoad()
}

protocol SuperHeroDetailPresenterToViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: SuperHeroDetailViewToPresenterProtocol? {get set}
    func showLoading()
    func hideLoading()
    func setupUI()
    func loadHeroImage()
    func loadHeroInformation()
}

protocol SuperHeroDetailPresenterToRouterProtocol: class {
    // PRESENTER -> ROUTER
    func showSuperHeroDetail(myHero: SuperHero?) -> UIViewController
}

protocol SuperHeroDetailPresenterToInteractorProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: SuperHeroDetailInteractorToPresenterProtocol? {get set}
}

protocol SuperHeroDetailInteractorToPresenterProtocol: class {
    // INTERACTOR -> PRESENTER
}
