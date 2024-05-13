//
//  SplashViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Dependency Properties
    
    private let viewModel: SplashViewModel
    
    // MARK: - UI Components
    
    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.splash.image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    // MARK: - Setup
    
    func prepareUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(splashImageView)
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            splashImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            splashImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            splashImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
}

extension SplashViewController: SplashViewProtocol {
    
    func startAnimation(
        duration: TimeInterval,
        delay: TimeInterval,
        completion: @escaping SplashAnimatableCompletion) {
        
        let swingForce = 0.8
                    
        animateLayer({ [weak self] in
            
            guard let self = self else { return }
            
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
            animation.values = [0, 0.3 * swingForce, -0.3 * swingForce, 0.3 * swingForce, 0]
            animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            animation.duration = CFTimeInterval(duration/2)
            animation.isAdditive = true
            animation.repeatCount = 2
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay/3)
            self.splashImageView.layer.add(animation, forKey: "swing")
            
        }, completion: {
            self.playZoomOutAnimation(duration: duration, completion: completion)
        })
        
    }
    
    private func playZoomOutAnimation(duration: TimeInterval, completion: @escaping SplashAnimatableCompletion) {
        
        let growDuration: TimeInterval =  duration * 0.3
        
        UIView.animate(withDuration: growDuration, animations:{
            
            self.splashImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.splashImageView.alpha = 0
            //When animation completes remote self from super view
        }, completion: { finished in
            self.splashImageView.removeFromSuperview()
            completion()
        })
        
    }
    
    private func animateLayer(_ execution: SplashAnimatableExecution, completion: @escaping SplashAnimatableCompletion) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        execution()
        CATransaction.commit()
    }
    
}


