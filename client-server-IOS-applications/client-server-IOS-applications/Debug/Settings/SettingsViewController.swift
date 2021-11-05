//
//  SettingsViewController.swift
//  lesson-9
//
//  Created by LACKY on 04.10.2021.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var loginUserLabel: UILabel!
    
    let session = Session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        
        userIDLabel.text = session.token
        loginUserLabel.text = session.userId
    }
    
    private func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func MainSettingsButton(_ sender: Any) {
        let vc = R.Storyboard.MainSettings.instantiateInitialViewController()!
        self.push(vc)
    }
    
    @IBAction func notificationsButton(_ sender: Any) {
        let vc = R.Storyboard.notifications.instantiateInitialViewController()!
        self.push(vc)
    }
    
    @IBAction func blackListButton(_ sender: Any) {
        let vc = R.Storyboard.blackList.instantiateInitialViewController()!
        self.push(vc)
    }
    
    @IBAction func ExitButton(_ sender: Any) {
        
    }
    
}



extension SettingViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop: return PopAnimator()
        case .push: return PushAnimator()
        default: return nil
        }
    }
}



class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceView = transitionContext.viewController(forKey: .from)?.view else {return}
        guard let desctinationView = transitionContext.viewController(forKey: .to)?.view else {return}
        
        transitionContext.containerView.insertSubview(desctinationView, belowSubview: sourceView)
        desctinationView.frame.origin.x = 50
        desctinationView.transform = .init(scaleX: 0.9, y: 0.9)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: []) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                sourceView.frame.origin.x = transitionContext.containerView.frame.width
                sourceView.transform = .init(scaleX: 1.1, y: 1.1)
                desctinationView.transform = .identity
                desctinationView.frame.origin.x = 0
            }
            
        } completion: {didCompleted in
            transitionContext.completeTransition(didCompleted)
        }
    }
}



class PushAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceView = transitionContext.viewController(forKey: .from)?.view else {return}
        guard let desctinationView = transitionContext.viewController(forKey: .to)?.view else {return}
        
        transitionContext.containerView.addSubview(desctinationView)
        desctinationView.frame.origin.x = transitionContext.containerView.frame.width
        desctinationView.transform = .init(scaleX: 1.1, y: 1.1)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: []){
            
            //1
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                sourceView.transform = .init(scaleX: 0.9, y: 0.9)
            }
            
            //2
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                sourceView.frame.origin.x = 50
            }
            
            //3
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                desctinationView.transform = .identity
                desctinationView.frame.origin.x = 0
            }
            
        } completion: { didComplete in
            sourceView.removeFromSuperview()
            transitionContext.completeTransition(didComplete)
        }
    }
    
    
}
