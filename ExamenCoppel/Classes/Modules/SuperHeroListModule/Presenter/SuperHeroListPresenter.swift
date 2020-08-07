//
//  SuperHeroListPresenter.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import UIKit

final class SuperHeroListPresenter {
    var view: SuperHeroListPresenterToViewProtocol?
    var router: SuperHeroListPresenterToRouterProtocol?
    var interactor: SuperHeroListPresenterToInteractorProtocol?
    
    var superheroList: [SuperHero]?
    var superheroTop10List: [SuperHero]?
    var pageNo = 0
    var offset = 0
    var limit = 10
    var limitSize = 10
}

extension SuperHeroListPresenter: SuperHeroListViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getSuperHeroByName()
    }
    
    func refresh() {
        offset = pageNo * limit
        pageNo += 1
        limit += limitSize
        self.requestSuperHeroListSuccess(superheroList: superheroList!)
    }
    
    func numberOfRowsInSection() -> Int {
        guard let superheroList = self.superheroTop10List else {
            return 0
        }
        return superheroList.count
    }
    
    func getHeroAtRow(index: Int) -> SuperHero{
        return superheroTop10List?[index] ?? SuperHero()
    }
    
    func didSelectRowAt(index: Int) {
        self.showSuperHeroDetailController(myHero: self.superheroTop10List?[index])
    }
    
    func showSuperHeroDetailController(myHero: SuperHero?) {
        self.router?.presentSuperHeroDetailModule(myHero: myHero, from: view!)
    }
    
    func searchHeroesByFilter(filter: String) -> [SuperHero]{
        print((superheroList?.filter{ (($0.name ?? "").contains(filter))}))
        return (superheroList?.filter{ ($0.name?.contains(filter))! })!
    }
}

extension SuperHeroListPresenter: SuperHeroListInteractorToPresenterProtocol {
    func requestSuperHeroListSuccess(superheroList: [SuperHero] ) {
        view?.showLoading()

        self.superheroList = superheroList
        self.superheroTop10List = superheroList.enumerated().compactMap{ $0.offset < limit ? $0.element : nil }.sorted{
            Int($0.id ?? "0")! > Int($1.id ?? "0")!
        }
        
        view?.onFetchSuperHeroSuccess()
    }
    
    func requestSuperHeroListFailure(superheroError: SuperHeroResponse) {
        view?.onFetchSuperHeroFailure()
//        view?.requestSuperHeroListFailure(error: error)
    }
}
