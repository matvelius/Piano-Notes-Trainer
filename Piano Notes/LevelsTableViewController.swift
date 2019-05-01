//
//  LevelsTableViewController.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class LevelsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "intro_screen_background_blurry"))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allLevels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell

        let level = allLevels[indexPath.row]
        
        cell.updateCell(with: level)
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.1)
        cell.selectedBackgroundView = selectedView

        
//        if cell.isSelected {
//            cell.backgroundColor = UIColor.red
////            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
//        } else {
//            cell.backgroundColor = UIColor.clear
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Level.currentLevel = allLevels[indexPath.row]
        
        
        if explainersOn {
        
            performSegue(withIdentifier: "segueToExplainers", sender: nil)
            
        } else {
            
            performSegue(withIdentifier: "segueToGame", sender: nil)
                
        }
        
    }
//    func configureCell() {
//
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
