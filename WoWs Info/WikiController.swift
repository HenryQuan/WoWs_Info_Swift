//
//  WikiController.swift
//  WoWs Info
//
//  Created by Henry Quan on 4/4/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit

class WikiController: UITableViewController {

    let name = [NSLocalizedString("ACHIEVEMENT", comment: "Achievement"), NSLocalizedString("WARSHIPS", comment: "Warships"), NSLocalizedString("UPGRADES", comment: "Upgrades"), NSLocalizedString("FLAGS", comment: "Flags"), NSLocalizedString("CAMOUFLAGE", comment: "Camouflage"), NSLocalizedString("COMMANDER_SKILL", comment: "CommanderSkill")]
    let identifier = ["gotoAchievement", "gotoWarships", "gotoWikiData"]
    let iconImage = [#imageLiteral(resourceName: "AchievementIcon"), #imageLiteral(resourceName: "Theme"), #imageLiteral(resourceName: "UpgradesIcon"), #imageLiteral(resourceName: "FlagsIcon"), #imageLiteral(resourceName: "CamouflageIcon"), #imageLiteral(resourceName: "CommanderSkillIcon")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("WOWS_WIKI", comment: "Wiki Title")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WikiCell", for: indexPath) as! WikiCell
        // Corner radius for image
        cell.wikiImage.layer.cornerRadius = cell.wikiImage.frame.width / 5
        cell.wikiImage.layer.masksToBounds = true
        
        // Change theme for warship
        let index = indexPath.row
        if index == 1 { // <-- It is a white icon...
            cell.wikiImage.backgroundColor = Theme.getCurrTheme()
        } else {
            cell.wikiImage.backgroundColor = UIColor.clear
        }
        
        cell.wikiTextLabel.text = name[indexPath.row]
        cell.wikiImage.image = iconImage[index]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 1 {
            performSegue(withIdentifier: identifier[2], sender: indexPath.row - 2)
        } else {
            if identifier[indexPath.row] == "gotoWarships" {
                // Ask user to share with friend or not
                if !UserDefaults.standard.bool(forKey: DataManagement.DataName.didShare) {
                    UserDefaults.standard.set(true, forKey: DataManagement.DataName.didShare)
                    // Ask User to share this app
                    let share = UIAlertController(title: "SHARE_TITLE".localised(), message: "SHARE_MESSAGE".localised(), preferredStyle: .alert)
                    share.addAction(UIAlertAction(title: "OK", style: .default, handler: { (Review) in
                        let shareActivity = UIActivityViewController.init(activityItems: [URL(string: "https://itunes.apple.com/app/id1202750166")!], applicationActivities: nil)
                        shareActivity.popoverPresentationController?.sourceView = self.view
                        shareActivity.modalPresentationStyle = .overFullScreen
                        self.present(shareActivity, animated: true, completion: nil)
                    }))
                    share.addAction(UIAlertAction(title: "SHARE_CANCEL".localised(), style: .cancel, handler: nil))
                    self.present(share, animated: true, completion: nil)
                }
            }
            performSegue(withIdentifier: identifier[indexPath.row], sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change text to "Back"
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("BACK", comment: "Back button")
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "gotoWikiData" {
            // We have to send seme data
            let destination = segue.destination as! WikiDataController
            destination.dataType = sender as! Int
        }
    }
    
}
