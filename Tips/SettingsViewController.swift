//
//  SettingsViewController.swift
//  Tips
//
//  Created by dawei_wang on 8/20/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let DEFAULT_PERCENTAGE_SETTING_KEY = "default_tip_percentage"
    
    @IBOutlet weak var defaultTipSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        let defaultPercentageIndex = defaults.integer(forKey: DEFAULT_PERCENTAGE_SETTING_KEY)
        defaultTipSegment.selectedSegmentIndex = defaultPercentageIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onTapDefaultTipPercentage(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTipSegment.selectedSegmentIndex, forKey: DEFAULT_PERCENTAGE_SETTING_KEY)
        defaults.synchronize()
    }

}
