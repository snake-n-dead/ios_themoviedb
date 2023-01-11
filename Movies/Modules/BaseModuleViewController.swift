//
//  BaseModuleViewController.swift
//

import UIKit

enum Alert {
    case text(text: String)
    case error(response: NetworkResponse)
}

protocol BaseModuleViewInput: BaseModuleViewController {

    func update(title: String, large: Bool)
    func show(info: Alert)
}

class BaseModuleViewController: UIViewController, Scrollable {

    var scroll: UIScrollView? { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
    }
    
    func update(title: String, large: Bool) {
        self.title = title
        
        navigationController?.navigationBar.prefersLargeTitles = large
        navigationController?.navigationBar.sizeToFit()
    }
    
    func show(info: Alert) {
        switch info {
        case .text(let text):
            showAlert(message: text)
        case .error(let response):
            showAlert(message: response.message)
        }
    }
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear),
            name: UIResponder.keyboardWillHideNotification, object: nil)
        
        scroll?.keyboardDismissMode = .interactive
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              scroll?.contentInset.bottom == 0 else { return }
        
        let newFrame = value.cgRectValue
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                left: 0,
                                                bottom: newFrame.height,
                                                right: 0)
        
        scroll?.contentInset = insets
        scroll?.scrollIndicatorInsets = insets
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        guard scroll?.contentInset.bottom != 0 else { return }
        
        let inset = UIEdgeInsets(top: 0,
                                 left: 0,
                                 bottom: 0,
                                 right: 0)
        
        scroll?.contentInset = inset
        scroll?.scrollIndicatorInsets = inset
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
