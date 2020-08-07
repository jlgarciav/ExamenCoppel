//
//  SuperHeroListInteractor.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation

final public class SuperHeroListInteractor {
    
    var presenter: SuperHeroListInteractorToPresenterProtocol?
}

extension SuperHeroListInteractor: SuperHeroListPresenterToInteractorProtocol {
    func getSuperHeroByName(){
        SuperHeroService.shared.getSuperHeroByNameService(success: { (heroResponse) in
            self.presenter?.requestSuperHeroListSuccess(superheroList: heroResponse.superheroList ?? [])
        }) { (code) in
            self.presenter?.requestSuperHeroListFailure(superheroError: code)
        }
    }
}
