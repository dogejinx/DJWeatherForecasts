//
//  ViewController.swift
//  DJWeatherProject
//
//  Created by linxian on 2017/2/20.
//  Copyright © 2017年 DogeJinx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherForecastsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func WeatherForecastsHandler(_ sender: UIButton) {
        
        let wfViewController = WeatherForecastsViewController()
        let navi = UINavigationController(rootViewController: wfViewController)
        
        let animation = CATransition()
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction.init(name: "easeInEaseOut")
        animation.type = "moveIn"
        animation.subtype = kCATransitionFromRight
        self.view.window?.layer.add(animation, forKey: nil)
        self.present(navi, animated: true) {
            
        }
    }

}

