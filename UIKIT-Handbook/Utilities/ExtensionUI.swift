//
//  ExtensionUI.swift
//  MVC-Mobile
//
//  Created by Ahmad Nur Alifulloh on 20/01/22.
//  Modified by Dhika Aditya AP on 08/06/22.
//

import Foundation
import UIKit
import SwiftUI
import TTGSnackbar

extension UINavigationBar {
    func setGradientBackgroundDefault() {
        var updatedFrame = bounds
        updatedFrame.size.height += 40
        
        let color1 = hexStringToUIColor(hex: "#184DAB")
        let color2 = hexStringToUIColor(hex: "#184DAB")
        let colors = [color1, color2 ]
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}

extension CAGradientLayer {
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
extension UITableView {
    func setEmptyTableView(message: String, messageImage: UIImage,btnHide: Bool, buttonTapAction1: @escaping () -> Void, buttonTapAction2: @escaping () -> Void ) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.backgroundColor = .white
        let messageImageView = UIImageView()
        let messageLabel = UILabel()
        let backtoHome = UIButton()
        let backtoSearch = UIButton()
        
        messageImageView.backgroundColor = .clear
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        backtoHome.translatesAutoresizingMaskIntoConstraints = false
        backtoSearch.translatesAutoresizingMaskIntoConstraints = false
        
        messageImageView.contentMode = .scaleAspectFit
        
        messageLabel.textColor = hexStringToUIColor(hex: "#486784")
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        backtoHome.setTitle("Kembali ke Beranda", for: .normal)
        backtoHome.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        backtoHome.setTitleColor(.white, for: .normal)
        backtoHome.layer.backgroundColor = hexStringToUIColor(hex: "#184DAB").cgColor
        backtoHome.layer.cornerRadius = 20
        backtoHome.layer.borderColor = hexStringToUIColor(hex: "#184DAB").cgColor
        buttonActionSearchfirst = buttonTapAction1
        backtoHome.addTarget(self, action: #selector(pressed1(_:)), for: .touchUpInside)
        
        backtoSearch.setTitle("Coba Kata kunci Lain", for: .normal)
        backtoSearch.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        backtoSearch.setTitleColor(hexStringToUIColor(hex: "#184DAB"), for: .normal)
        backtoSearch.layer.backgroundColor = UIColor.white.cgColor
        backtoSearch.layer.cornerRadius = 20
        backtoSearch.layer.borderColor = hexStringToUIColor(hex: "#184DAB").cgColor
        backtoSearch.layer.borderWidth = 1
        buttonActionSearchsecond  = buttonTapAction2
        backtoSearch.addTarget(self, action: #selector(pressed2(_:)), for: .touchUpInside)
        
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(backtoHome)
        emptyView.addSubview(backtoSearch)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -80).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 2).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backtoHome.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8).isActive = true
        backtoHome.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        backtoHome.widthAnchor.constraint(equalToConstant: 170).isActive = true
        backtoHome.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        backtoSearch.topAnchor.constraint(equalTo: backtoHome.bottomAnchor, constant: 8).isActive = true
        backtoSearch.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        backtoSearch.widthAnchor.constraint(equalToConstant: 170).isActive = true
        backtoSearch.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        messageImageView.image = messageImage
        messageLabel.text = message
        backtoHome.isHidden = btnHide
        backtoSearch.isHidden = btnHide
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
            
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    @objc func pressed1(_ sender: UIButton) {
       guard let action = buttonActionSearchfirst else {
           print("tidak ada aksi")
           return
       }
       action()
     }
    @objc func pressed2(_ sender: UIButton) {
       guard let action = buttonActionSearchsecond else {
           print("tidak ada aksi")
           return
       }
       action()
     }
    
}
var buttonActionSearchfirst: (() -> Void)?
var buttonActionSearchsecond: (() -> Void)?

extension UIViewController{
    func gotoRootViewController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyBoard.instantiateViewController(withIdentifier: "TabViewController") as! TabBarViewController
        
        let snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
        rootController.view.addSubview(snapshot)
        
        UIApplication.shared.keyWindow?.rootViewController = rootController
        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .curveEaseInOut,
                          animations: {
            snapshot.layer.opacity = 0
        },
                          completion: { status in
            snapshot.removeFromSuperview()
        })
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    func snakeBar(message: String, duration: TTGSnackbarDuration = .middle, backgroundColor: UIColor? = hexStringToUIColor(hex: "#FFE4E4"), borderColor: UIColor? = hexStringToUIColor(hex: "#B44242"), textColor: UIColor? = hexStringToUIColor(hex: "#B44242")){
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
        
    }
    
    func snakeBarGreen(message: String, duration: TTGSnackbarDuration = .middle, backgroundColor: UIColor? = hexStringToUIColor(hex: "#DCF8E7"), borderColor: UIColor? = hexStringToUIColor(hex: "#219155"), textColor: UIColor? = hexStringToUIColor(hex: "#219155")){
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func convertPhoneNumberFormat(currNumber: String) -> (String, Bool){
        var newPhoneNumb: String = ""
        if String(currNumber.prefix(2)) == "62"{
            let tempPhoneNumb = String(currNumber.suffix(currNumber.count - 2))
            print("ini no telp: \(tempPhoneNumb)")
            newPhoneNumb = "+62\(tempPhoneNumb)"
            return (newPhoneNumb, true)
            
        }else if String(currNumber.prefix(2)) == "08"{
            let tempPhoneNumb = String(currNumber.suffix(currNumber.count - 2))
            print("ini no telp: \(tempPhoneNumb)")
            newPhoneNumb = "+628\(tempPhoneNumb)"
            return (newPhoneNumb, true)
            
        }else if String(currNumber.prefix(3)) == "+62"{
            newPhoneNumb = currNumber
            return (newPhoneNumb, true)
        }else{
           return (currNumber, false)
        }
    }
    
    //MARK: Start - Manage Loading
    func manageLoadingActivity(isLoading: Bool) {
        if isLoading {
            showLoadingActivity()
        } else {
            hideLoadingActivity()
        }
    }
    
    func showLoadingActivity() {
        self.view.makeToastActivity(.center)
    }
    
    func hideLoadingActivity() {
        self.view.hideToastActivity()
    }
    //MARK: End - Manage Loading
    
}

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}

extension Int {
    func secondsToMinutesSeconds() -> String {
        let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(m_string):\(s_string)"
    }
}

extension UIView{
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornersRadius
        layer.masksToBounds = false
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
