//
//  String+Extension.swift
//  ExamenCoppel
//
//  Created by José Luis García on 06/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import Foundation

extension String{
    func URLEncodedString() -> String? {
        let customAllowedSet =  CharacterSet.urlQueryAllowed
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        return escapedString
    }
}
