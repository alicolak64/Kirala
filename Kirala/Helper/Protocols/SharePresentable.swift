//
//  Shareable.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

protocol SharePresentable {
    func share(item: Any)
}

extension SharePresentable where Self: UIViewController {
    func share(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        activityViewController.popoverPresentationController?.permittedArrowDirections = []
        present(activityViewController, animated: true, completion: nil)
    }
}
