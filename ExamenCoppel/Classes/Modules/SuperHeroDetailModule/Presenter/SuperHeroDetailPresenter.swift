//
//  SuperHeroDetailPresenter.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

final class SuperHeroDetailPresenter {
    var view: SuperHeroDetailPresenterToViewProtocol?
    var router: SuperHeroDetailPresenterToRouterProtocol?
    var interactor: SuperHeroDetailPresenterToInteractorProtocol?
    var superHeroDetail: SuperHero?
}

extension SuperHeroDetailPresenter: SuperHeroDetailViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        view?.setupUI()
        view?.loadHeroImage()
        view?.loadHeroInformation()
        view?.hideLoading()
    }
}

extension SuperHeroDetailPresenter: SuperHeroDetailInteractorToPresenterProtocol {
}
