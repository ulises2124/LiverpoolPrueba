//
//  Loader.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation
import UIKit

public class Loader {

    public static let sharedInstance = Loader()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .cyan
        
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {

            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    func hideIndicator(){

        DispatchQueue.main.async( execute:
            {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
                
        })
    }
}

