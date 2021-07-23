//
//  Indicator.swift
//  BetKing
//
//  Created by MAC on 23/07/21.
//

import Foundation
import UIKit

final class Indicator {
    static let shared = Indicator()
    
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    
    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
     //   indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = UIColor.white
    }
    
    func show(){
        DispatchQueue.main.async( execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    
    func hide(){
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}
