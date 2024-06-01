//
//  LottieViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 1.06.2024.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
    private var animationView: LottieAnimationView?
    private var lotie: Lottie?
    private let completion: (() -> Void)?

    init(lottie: Lottie, completion: (() -> Void)? = nil) {
        self.completion = completion
        self.lotie = lottie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAnimation()
    }

    private func setupAnimation() {
        animationView = LottieAnimationView(name: lotie?.animationName ?? "")
        animationView?.frame = view.bounds
        animationView?.contentMode = lotie?.contentMode ?? .scaleAspectFit
        animationView?.loopMode = lotie?.loopMode ?? .playOnce
        animationView?.animationSpeed = lotie?.speed ?? 1.0
        view.addSubview(animationView ?? UIView())

        animationView?.play { [weak self] (finished) in
            self?.completion?()
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

