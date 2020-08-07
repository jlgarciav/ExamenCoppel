//
//  SuperHeroService.swift
//  ExamenCoppel
//
//  Created by José Luis García on 06/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation

class SuperHeroService {
    
    static let shared = { SuperHeroService() }()
    
    func getSuperHeroByNameService(success: @escaping (SuperHeroResponse) -> (), failure: @escaping (SuperHeroResponse) -> ()) {
        let encodedURL = Endpoints.SEARCH_NAME.replacingOccurrences(of: "{0}", with: "a")
        let myUrl = NSURL(string: encodedURL);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        SupperHeroServiceMapper().serviceRequest(request: request as URLRequest) { (data) in
            let heroResponse = data as? SuperHeroResponse
            
            if  heroResponse != nil{
                if (heroResponse?.response == "success"){
                    success(heroResponse!)
                }
                else{
                    failure(SuperHeroResponse())
                }
            }
            else{
                failure(SuperHeroResponse())
            }
        }
    }

    
    func configureApiCall(_ baseURL: String, _ parameter: String, _ value: String) -> String {
        return baseURL + "?" + parameter + "=" + value
    }
}
