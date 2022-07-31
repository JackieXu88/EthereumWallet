//
//  ETHShareKits.swift
//  EthereumWallet
//
//  Created by Jackie Xu on 2022/7/31.
//

import Foundation


struct ETHShareKits {
    
    static func share(message: String) {
        let shareText = message
        let activity = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activity.excludedActivityTypes = [.addToReadingList,.assignToContact,.markupAsPDF, .openInIBooks,.postToVimeo]
        UIViewController.topMost?.present(activity, animated: true)
    }
    
}
