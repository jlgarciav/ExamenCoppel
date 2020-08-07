//
//  UIImage+Extension.swift
//  ExamenCoppel
//
//  Created by José Luis García on 06/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import UIKit

class SemiRoundImageView: UIImageView {
    override var bounds: CGRect {
        get {
            return super.bounds
        }
        set {
            super.bounds = newValue
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        clipsToBounds = true
    }
}
