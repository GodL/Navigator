//
//  LoginController.swift
//  Example
//
//  Created by lihao10 on 2021/1/18.
//

import UIKit
import Navigator

class LoginController: UIViewController {
    
    var completion: () -> Void = {}

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.setTitle("Login...", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func login() {
        isLogin = true
        NavigatorRouter.router.navigate(Navigators.dismiss, context: ())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.completion()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
