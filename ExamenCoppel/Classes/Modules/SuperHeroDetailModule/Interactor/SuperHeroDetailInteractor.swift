//
//  SuperHeroDetailInteractor.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation

final public class SuperHeroDetailInteractor {
    
    var presenter: SuperHeroDetailInteractorToPresenterProtocol?
}

extension SuperHeroDetailInteractor: SuperHeroDetailPresenterToInteractorProtocol {

}
