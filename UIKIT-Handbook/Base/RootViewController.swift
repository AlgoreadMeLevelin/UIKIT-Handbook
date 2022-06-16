//
//  RootViewController.swift
//  UIKIT-Handbook
//
//  Created by DHIKA ADITYA on 16/06/22.
//

import Foundation
import UIKit

enum BackgroundColorType: String {
  case white = "navigationBackgroundWhite"
  case blue = "navigationBackground"
}

class RootViewController: UINavigationController {
  
  // MARK: - Lifecycle
  private let currentVersion = (UIDevice.current.systemVersion as NSString).floatValue
  override func viewDidLoad() {
    super.viewDidLoad()
    self.edgesForExtendedLayout = .all
    self.extendedLayoutIncludesOpaqueBars = false
    self.navigationBar.isOpaque = false
    setNavigationBar()
  }
  
  private func setNavigationBar() {
    
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.gray
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navigationBar.compactAppearance = appearance
      navigationBar.standardAppearance = appearance
      navigationBar.scrollEdgeAppearance = appearance
    }
    navigationItem.hideBackButtonTitle = true
    navigationBarIsTranslucent(false)
    setBackgroundImageToNil()
  }
  
  // Configuration for iOS 12.x
  public func setBackgroundImageToNil() {
    if self.currentVersion <= 12.9 {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationBar.shadowImage = UIImage()
      navigationBar.shouldRemoveShadow(true)
    }
  }
  
  public func setNavigationBarForOldDevices() {
    self.navigationBarIsTranslucent(false)
    self.setBackgroundImageToNil()
  }
  
  public func setBackgroundWithImage(backgroundColor: BackgroundColorType = .blue) {
    if self.currentVersion <= 12.9 {
      navigationBar.shadowImage = UIImage(named: backgroundColor.rawValue)?.withRenderingMode(.alwaysOriginal)
      navigationBar.setBackgroundImage(UIImage(named: backgroundColor.rawValue)?.withRenderingMode(.alwaysOriginal), for: .default)
    }
  }
  
  public func navigationBarIsTranslucent(_ bool: Bool) {
    if self.currentVersion <= 12.9 {
      navigationBar.isTranslucent = bool
      navigationBar.isOpaque = true
    }
  }
  
  public func setBackgroundColor(with color: UIColor? = hexStringToUIColor(hex: "#184DAB"), titleColor: UIColor? = .white) {
    if #available(iOS 13.0, *) {
      navigationBar.compactAppearance?.backgroundColor = color
      navigationBar.scrollEdgeAppearance?.backgroundColor = color
      navigationBar.standardAppearance.backgroundColor = color
      navigationBar.compactAppearance?.titleTextAttributes = [.foregroundColor: titleColor!]
      navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: titleColor!]
      navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: titleColor!]
    } else if self.currentVersion <= 12.9 {
      self.setBackgroundWithImage()
      navigationBar.shouldRemoveShadow(true)
    }
    
  }
}

extension UINavigationItem {
  
  var hideBackButtonTitle: Bool {
    get { return false }
    set {
      if newValue == true {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButton.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        backBarButton.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
        backBarButtonItem = backBarButton
      }
    }
  }
}

protocol WhiteNavBar {}
extension WhiteNavBar where Self: UIViewController {
  
  private func setDarkStatusBar() {
    if #available(iOS 13.0, *) {
      UIApplication.shared.statusBarStyle = .darkContent
    } else {
      UIApplication.shared.statusBarStyle = .default
    }
  }
  
  private func setLightStatusBar() {
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  func setNavigationBackground() {
    if let nav = navigationController as? RootViewController {
      nav.setBackgroundColor(with: .white, titleColor: hexStringToUIColor(hex: "#184DAB"))
      nav.setBackgroundWithImage(backgroundColor: .white)
      nav.navigationBar.titleTextAttributes = [.foregroundColor: hexStringToUIColor(hex: "#184DAB")]
        nav.navigationBar.layer.shadowColor = UIColor.gray.cgColor
      nav.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
      nav.navigationBar.layer.shadowRadius = 0.5
      nav.navigationBar.layer.shadowOpacity = 1.0
    }
    setDarkStatusBar()
  }
  
  func resetNavigationBackground() {
    if let nav = navigationController as? RootViewController {
      nav.setBackgroundColor(with: hexStringToUIColor(hex: "#184DAB"), titleColor: .white)
      nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      nav.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
    setLightStatusBar()
  }
}
