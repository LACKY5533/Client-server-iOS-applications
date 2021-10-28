//
//  ViewController.swift
//  lesson-3
//
//  Created by LACKY on 06.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var ScrollView: UIScrollView!
    
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet private weak var LoginText: UITextField!
    @IBOutlet private weak var PasswordText: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet private weak var ChangeLabel: UILabel!
    
   // let account = Account.shared
    
    
    //Данные пользователей
    var loginPasswordDict: [String: String] = ["admin": "admin", "12345": "12345", "54321": "54321", "qwerty": "qwerty"]
    var loginUserIDDict: [String: String] = ["admin": "id000001", "12345": "id000002", "54321": "id000003", "qwerty": "id000004"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        
        animateChangeLabel()
        animateLabels(labelField: loginLabel, move: -300)
        animateLabels(labelField: passwordLabel, move: 300)
        animateTextField(textField: LoginText)
        animateTextField(textField: PasswordText)
        animateSinInButton()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    private func addGesture () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        self.ScrollView.addGestureRecognizer(gesture)
    }
    
    @objc private func handleGesture() {
        self.ScrollView.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardWillShow),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardWillHide),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default
            .removeObserver(self,
                            name: UIResponder.keyboardWillShowNotification,
                            object: nil)
        
        NotificationCenter.default
            .removeObserver(self,
                            name: UIResponder.keyboardWillShowNotification,
                            object: nil)
    }
    
    @objc private func handleKeyboardWillShow() {
        self.ScrollView.contentInset.bottom = 120
    }
    
    @objc private func handleKeyboardWillHide() {
        self.ScrollView.contentInset.bottom = 0
    }
    
    
    
    
    private func animateChangeLabel() {
            self.ChangeLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
            UIView.animate(withDuration: 1,
                            delay: 0.5,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0,
                            options: .curveEaseOut,
                            animations: {
                                self.ChangeLabel.transform = .identity
                               },
                               completion: nil)
    }
    
    private func animateLabels(labelField : UILabel, move: Float) {
        labelField.transform = CGAffineTransform(translationX: CGFloat(move), y: 0)
        UIView.animate(withDuration: 1,
                        delay: 0.5,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 0,
                        options: .curveEaseOut,
                        animations: {
                            labelField.transform = .identity
                        },
                        completion: nil)
    }
    
    private func animateTextField(textField: UITextField) {
        textField.alpha = 0.0
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
            textField.alpha = 1.0
        })
    }
    
    private func animateSinInButton() {
        UIView.animate(withDuration: 0.5,
        animations: {
            self.signInButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.signInButton.transform = CGAffineTransform.identity
                }
            })
    }
    
    
    
    
    private func checkPassword() {
        let login = self.LoginText.text!
        let password = self.PasswordText.text!
        
        if loginPasswordDict[login] != nil && password == loginPasswordDict[login] {
            self.showAdminScene()
        }else {
            self.showAllert()
        }
    }
    
    private func showAdminScene() {
        
//        let name = LoginText.text
//        let userID = loginUserIDDict[self.LoginText.text!]
        
//        account.name = name!
//        account.userID = userID!
        
        let tabbar = R.Storyboard.DebugMenu.instantiateInitialViewController()
            self.present(tabbar!, animated: true)
    }
    
    private func showAllert() {
        let allertController = UIAlertController(
            title: "Ошибка",
            message: "Введены неверные данные!",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "ОК",
            style: .cancel)
        
        allertController.addAction(action)
        self.present(allertController, animated: true)
    }

    @IBAction private func onButtonPressed(_ sender: Any) {
        self.checkPassword()
    }
    
    }

