//
//  Extensiones.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation
import UIKit
var loader: UIView?
extension UINavigationBar
{
    func applyGradient(gradient colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar

        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        let cgcolors = colors.map { $0.cgColor }
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        defer { UIGraphicsEndImageContext() }
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }

        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIViewController {
    
   
    
    func presentAlert(withTitle title: String, message: String, isCorrectAction: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { action in
            isCorrectAction()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { action in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
      }
    
   
    
    }


extension UITextField {
    func setBottomBorderSelected(wide: CGFloat) {
           self.borderStyle = UITextField.BorderStyle.none
           self.backgroundColor = UIColor.clear
           let width = 1.0
           
           let borderLine = UIView()
           borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(wide), height: width)
           
        borderLine.backgroundColor = Colors.mango
           self.addSubview(borderLine)
       }
    
    func setBottomBorderNormal(wide: CGFloat){
        self.borderStyle = UITextField.BorderStyle.none
                  self.backgroundColor = UIColor.clear
                  let width = 1.0
                  
                  let borderLine = UIView()
                  borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(wide), height: width)
                  
        borderLine.backgroundColor = .black
                  self.addSubview(borderLine)
    }
}

extension UIView {
    
    func createGradientLayer(view:UIView, color1: UIColor, color2: UIColor) -> CAGradientLayer {
          var gradientLayer: CAGradientLayer!
          var colorSets = [[CGColor]]()
           colorSets.append([color1.cgColor, color2.cgColor])
           gradientLayer = CAGradientLayer()
           gradientLayer.frame = view.bounds
           gradientLayer.colors = colorSets[0]
           gradientLayer.locations = [0.0, 0.35]
           
           gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.45)
           gradientLayer.endPoint = CGPoint(x: 0, y: 1)
           return gradientLayer
       }
   
    func shakeError() {
               let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
               animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
               animation.duration = 0.6
               animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
               layer.add(animation, forKey: "shake")
           }
    
    func roundFrame(_ aView: UIView!, borderWidth: CGFloat!, cornerRadius: CGFloat!, borderColor: UIColor?) {
               
               aView.layer.borderWidth = borderWidth
               aView.layer.borderColor = borderColor?.cgColor
               return aView.layer.cornerRadius = cornerRadius
           }
}

extension Error {
    func printDescription() {
        print(self)
    }
}


extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
