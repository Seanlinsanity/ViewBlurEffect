//
//  ViewController.swift
//  UIViewPropertyAnimatorBlurEffect
//
//  Created by SEAN on 2018/11/7.
//  Copyright © 2018 SEAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "warriors"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: nil)
    let visualEffectView = UIVisualEffectView(effect: nil)

    @objc private func handleSlider(slider: UISlider){
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    private func setupAnimator(){
        animator.addAnimations { [weak self] in
            //completed animation state
            self?.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self?.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAnimator()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    private func setupVisualBlurEffectView(){
//        let blurEffect = UIBlurEffect(style: .regular)
        view.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
    }
    
    private func setupUI(){
        view.addSubview(imageView)
        imageView.centerInSuperview(size: CGSize(width: 200, height: 200))
        
        setupVisualBlurEffectView()
        
        view.addSubview(slider)
        slider.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor)
    }

    @objc private func handleTap(){
        UIView.animate(withDuration: 1) {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
}

