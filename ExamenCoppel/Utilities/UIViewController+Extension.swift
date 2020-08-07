//
//  UIViewController+Extension.swift
//  ExamenCoppel
//
//  Created by José Luis García on 06/08/20.
//  Copyright © 2020 José Luis García. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController{
    func renderStatusBarTransparent(){
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
    
    func downloadImage(containerImage: UIImageView, from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                containerImage.image = UIImage(data: data)
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func showHUD() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(UIColor(red: 0/255, green: 154/255, blue: 221/255, alpha: 1.0))
        SVProgressHUD.show()
    }
    
    func dismissHUD() {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
        })
    }
}
