//
//  LoadingView.swift
//  Kirala
//
//  Created by Ali Çolak on 15.05.2024.
//

import UIKit

/// A view that displays a loading indicator.
final class LoadingView: UIView, LoadingViewProtocol {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHud()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    /// Sets up the layout of the loading view.
    private func setupHud() {
        ProgressHUD.colorAnimation = ColorPalette.appPrimary.dynamicColor
        ProgressHUD.animationType = .semiRingRotation
        
        ProgressHUD.colorHUD = ColorBackground.primary.dynamicColor
        
    }
    
    // MARK: - Methods
    
    private func showHud() {
        ProgressHUD.animate(interaction: false)
    }
    
    private func hideHud(loadResult: LoadingResult) {
        switch loadResult {
        case .success:
            ProgressHUD.succeed(interaction: false)
        case .failure:
            ProgressHUD.failed(interaction: false)
        case .none:
            ProgressHUD.dismiss()
        }
    }
    
    // MARK: - LoadingViewProtocol
    
    func showLoading() {
        showHud()
    }

    
    func hideLoading(loadResult: LoadingResult = .none) {
        hideHud(loadResult: loadResult)
    }
    
}
