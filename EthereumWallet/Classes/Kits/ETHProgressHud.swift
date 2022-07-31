//
//  EthProgressHud.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/30.
//

import Foundation
import SVProgressHUD
/// completion handler
public typealias ProgressHudDismissCompletion = () -> Void
let kHUDDuration = 1.2
let kMessage = "loading..."
let fontSize = UIFont.systemFont(ofSize: 15)
/// PCN progress hud
public class ETHProgressHud {
    
    /// dismiss hud
    public static func dismissHud() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    /// show activity hud
    public static func showActivityHud() {
        showActivityHud(with: kMessage)
    }
    
    /// show activity hud with customized message
    public static func showActivityHud(with msg:String) {
        SVProgressHUD.dismiss()
        configureHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: msg)
        }
    }
    
    /// show success hud
    public static func showSuccessHud(with msg:String) {
        SVProgressHUD.dismiss()
        configureTipHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: msg)
        }
    }
    ///
    public static func showSuccessHud(with msg:String, completion: @escaping ProgressHudDismissCompletion) {
        showSuccessHud(with: msg, duration: kHUDDuration, completion: completion)
    }
    ///
    public static func showSuccessHud(with msg: String, duration:Double, completion: ProgressHudDismissCompletion?) {
        SVProgressHUD.dismiss()
        configureTipHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: msg)
        }
        SVProgressHUD.dismiss(withDelay: duration) {
            completion?()
        }
    }
    
    /// show error hud
    public static func showErrorHud(with msg:String) {
        SVProgressHUD.dismiss()
        configureTipHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.show(EthereumImages.Common.networkError.image, status: msg)
        }
    }
    
    /// show info hud
    public static func showInfoHud(with msg:String) {
        SVProgressHUD.dismiss()
        configureTipHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.showInfo(withStatus: msg)
        }
    }
    
    /// show network error hud
    public static func showNetworkErrorHud(_ msg: String = EthereumString.Common.networkError.localizedString) {
        SVProgressHUD.dismiss()
        configureTipHudStyle()
        DispatchQueue.main.async {
            SVProgressHUD.show(EthereumImages.Common.networkError.image, status: msg)
        }
    }
    
    /// show hud with msg
    public static func showHud(with msg:String) {
        showHud(with: msg, duration: kHUDDuration, completion: nil)
    }
    
    /// show hud with msg and duration
    public static func showHud(with msg:String, duration:Double) {
        showHud(with: msg, duration: duration, completion: nil)
    }
    
    /// show hud with msg and completion handler
    public static func showHud(with msg:String, completion: @escaping ProgressHudDismissCompletion) {
        showHud(with: msg, duration: kHUDDuration, completion: completion)
    }
    
    /// the full method for display hud
    public static func showHud(with msg:String, duration:Double, completion:ProgressHudDismissCompletion?) {
        SVProgressHUD.dismiss()
        configureHudStyle()
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -1))
        SVProgressHUD.show(UIImage.init(), status: msg)
        SVProgressHUD.dismiss(withDelay: duration) {
            SVProgressHUD.setImageViewSize(CGSize(width: 28, height: 28))
            completion?()
        }
    }
    
    private static func configureTipHudStyle() {
        SVProgressHUD.setDefaultMaskType(.clear)
        configureDefaultStyle()
        SVProgressHUD.setCornerRadius(0)
        SVProgressHUD.setMinimumDismissTimeInterval(kHUDDuration)
        SVProgressHUD.setFont(fontSize)
    }
    
    private static func configureHudStyle() {
        SVProgressHUD.setDefaultMaskType(.clear)
        configureDefaultStyle()
        SVProgressHUD.setCornerRadius(0)
        SVProgressHUD.setFont(fontSize)
    }
    
    
    private static func configureDefaultStyle() {
        if let style = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.traitCollection.userInterfaceStyle {
            switch style {
            case .dark:
                SVProgressHUD.setDefaultStyle(.light)
            default:
                SVProgressHUD.setDefaultStyle(.dark)
            }
        }
    }
    
}

