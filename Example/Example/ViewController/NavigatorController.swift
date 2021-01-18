//
//  NavigatorController.swift
//  Example
//
//  Created by GodL on 2021/1/18.
//

import UIKit
import Navigator

class NavigatorController: UIViewController {
    
    var buttonTitle: String = ""

    @IBOutlet weak var navigatorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigatorButton.setTitle(buttonTitle, for: .normal)
        
        navigatorButton.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func action(sender: UIButton) {
        if buttonTitle == "Push Navigator" || buttonTitle == "Interceptor Navigator" {
            NavigatorRouter.router.navigate(Navigators.pop, context: ())
        }else if buttonTitle == "Present Navigator" {
            NavigatorRouter.router.navigate(Navigators.dismiss, context: ())
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
