//
//  RootController.swift
//  Example
//
//  Created by GodL on 2021/1/18.
//

import UIKit
import Navigator

class RootController: UITableViewController {
    
    let datas = [
        "Push Navigator",
        "Present Navigator",
        "Interceptor Navigator",
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = datas[indexPath.row]
        if indexPath.row == 0 {
            NavigatorRouter.router.navigate(Navigators.push, context: title)
        }else if indexPath.row == 1 {
            NavigatorRouter.router.navigate(Navigators.present, context: title)
        }else if indexPath.row == 2 {
            NavigatorRouter.router.navigate(Navigators.pushWithInterceptor, context: title)
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
