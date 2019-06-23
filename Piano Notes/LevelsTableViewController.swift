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
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        if let retrievedLevelInfo = AppData.loadFromFile() {
            levelsCompleted = retrievedLevelInfo
            tableView.reloadData()
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        let navBar = self.navigationController?.navigationBar
//        
////        navBar?.isTranslucent = true
//        navBar?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
//        
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allLevels[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell

        let level = allLevels[indexPath.section][indexPath.row]
        
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
        return view.frame.height / 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Level.currentLevel = allLevels[indexPath.section][indexPath.row]
      
        // FREE PLAY - NOTE NAMES
        if (-3)...(-2) ~= Level.currentLevel.id {
            
            if explainersEnabled {
                performSegue(withIdentifier: "segueToExplainers", sender: nil)
            } else {
                performSegue(withIdentifier: "segueToGame", sender: nil)
            }
        
        // FREE PLAY - NOTES ON STAFF
        } else if (-1)...(0) ~= Level.currentLevel.id {
            
            if explainersEnabled {
                performSegue(withIdentifier: "segueToExplainers", sender: nil)
            } else {
                performSegue(withIdentifier: "segueToNotesOnStaff", sender: nil)
            }
        
        // LEVELS - NOTES ON STAFF
        } else if Level.currentLevel.id >= 8 {
            
            performSegue(withIdentifier: "segueToNotesOnStaff", sender: nil)
            
        } else if explainersEnabled {
        
            performSegue(withIdentifier: "segueToExplainers", sender: nil)
            
        // NOTE NAMES
        } else {
            
            performSegue(withIdentifier: "segueToGame", sender: nil)
                
        }
        
    }
//    func configureCell() {
//
//    }
    
    let titles = ["Naming the notes on the piano", "Learning music notation"]
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 70
    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//        guard let headerView = view as? UITableViewHeaderFooterView else { return }
//
//        headerView.backgroundView?.backgroundColor = .red
//    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

//        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(1)

        view.tintColor = UIColor.white

        let header = view as! UITableViewHeaderFooterView



        if let textLabel = header.textLabel {
//            textLabel.font = textLabel.font.withSize(50)
//            header.isOpaque = true
//            header.tintColor = .black
            textLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            textLabel.textColor = .white
//            textLabel.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
//            textLabel.shadowOffset = CGSize(width: 2, height: 2)
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.textAlignment = .center
        }


    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let returnedView = UIView(frame: CGRect(x: x, y: y, width: width, height: height)) //set these values as necessary
//        returnedView.backgroundColor = .white
//
//        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
//
//        label.text = self.sectionHeaderTitleArray[section]
//        returnedView.addSubview(label)
//
//        return returnedView
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
    @IBAction func unwindToLevels(unwindSegue: UIStoryboardSegue) {
        
    }

}
