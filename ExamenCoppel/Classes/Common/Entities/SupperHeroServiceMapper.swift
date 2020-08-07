//
//  SupperHeroServiceMapper.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation
import ObjectMapper

class SupperHeroServiceMapper{
    
    func serviceRequest(request: URLRequest, completion: @escaping (_ result: AnyObject?) -> Void)
    {
        if Reachability.isConnectedToNetwork() == true {
            RequestHandlers().getRequest(request: request as URLRequest) { (sData) in
                do{
                    if (sData != nil){
                        let responseOk = Mapper<SuperHeroResponse>().map(JSONString: sData!)
                        print(sData!)
                        if (responseOk != nil){
                            completion(responseOk as AnyObject)
                        }
                        else{
                            completion(nil)
                        }
                    }
                    else{
                        completion(nil)
                    }
                }catch{
                    completion(nil)
                }
            }
        }
        else{
            let heroError = SuperHeroResponse()
            heroError.response = "error"
            heroError.error = "No se ha podido conectar con el servidor. Comprueba tu conexión a Internet y vuelve a intentarlo."
            completion(heroError as AnyObject)
        }
    }
}
