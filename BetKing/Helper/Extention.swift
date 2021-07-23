//
//  Extension.swift
//  HungryGroceryDeliveryBoy
//
//  Created by APPLE on 14/06/21.
//

import Foundation
import UIKit
//import SWRevealViewController

extension UIView
{
    var YH : CGFloat{
        return self.frame.size.height+self.frame.origin.y
    }
    var XW : CGFloat{
        return self.frame.size.width+self.frame.origin.x
    }
    var Width : CGFloat{
        return self.frame.size.width
    }
    var Height : CGFloat{
        return self.frame.size.height
    }
    var X : CGFloat{
        return self.frame.origin.x
    }
    var Y : CGFloat{
        return self.frame.origin.y
    }
    func makeBorder() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 0.5
        //self.layer.borderColor = primary_color.cgColor
    }
    
    func open_animation() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1.0
        }
    }
    func close_animation() {
        UIView.animate(withDuration: 0.4) {
            self.alpha = 0.0
        }
    }
    
    func setBorderWithCorner(_ radius: CGFloat, color: UIColor) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func setBorderWithoutCorner(_ color: UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func setCorner(_ radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    func gradientView() {
        let layer = CAGradientLayer()
        layer.colors = [
          UIColor(red: 0.149, green: 0.345, blue: 0.624, alpha: 1).cgColor,
          UIColor(red: 0.078, green: 0.114, blue: 0.278, alpha: 1).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.02, b: 1.03, c: -1.04, d: 1.02, tx: 0.52, ty: -0.52))
        layer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        layer.position = self.center
        self.layer.addSublayer(layer)
    }
    
    func addShadow(colorIs : UIColor = UIColor.black, radiusShadow : CGFloat = 3){
        self.layer.shadowColor = colorIs.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = radiusShadow
    }
    
    func addBottomShadow(colorIs : UIColor = UIColor.black, radiusShadow : CGFloat = 10){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }
    
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//            let mask = CAShapeLayer()
//            mask.path = path.cgPath
//            layer.mask = mask
//    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11, *) {
                self.clipsToBounds = true
                self.layer.cornerRadius = radius
                var masked = CACornerMask()
                if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
                if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
                if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
                if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
                self.layer.maskedCorners = masked
            }
            else {
                let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
            }
        }
  
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

extension UITextField {
    func addPedding(_ pedding: CGFloat = 15) {
        let peddingView = UIView(frame: CGRect(x: 0, y: 0, width: pedding, height: pedding))
        self.leftView = peddingView
        self.leftViewMode = .always
    }
}

extension String{
    func strock() -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
extension UIViewController {

//    func setup_sidemenu(_ button: UIButton) {
//        if self.revealViewController() != nil {
////            print(self.revealViewController()?.rearViewRevealWidth)
////            self.revealViewController().frontViewShadowOpacity = 0.0;
//            revealViewController()?.rearViewRevealWidth = 280
//            //if isarabicLng{
//
//
//            //}else{
//                button.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//           // }
//
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//        }
//    }
    
//    func goToDashboard() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        self.present(vc, animated: true, completion: nil)
//    }
    
    func ShowAlert(msg : String) {
        
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
