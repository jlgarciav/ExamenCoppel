//
//  RequestHandlers.swift
//  ExamenCoppel
//
//  Created by José Luis García on 05/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation

class RequestHandlers {
    
    /**
     METODO GENERICO PARA HACER LLAMADAS AL SERVIDOR
     
     - Parameter request:   REQUEST DE LA PETICION.
     
     - Returns: LA RESPUESTA JSON EN FORMATO STRING.
     */
    func getRequest(request: URLRequest, _ completion: @escaping (_ result: String?) -> Void){
        var task:URLSessionDataTask?
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = TimeInterval(320)
        urlconfig.timeoutIntervalForResource = TimeInterval(320)
        let session = URLSession(configuration: urlconfig, delegate: self as? URLSessionDelegate, delegateQueue: OperationQueue.main)
        
        task = session.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                completion(nil)
                return
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let jsonString = (responseString! as String)
            
            completion(jsonString)
        }
        task?.resume()
    }
}
