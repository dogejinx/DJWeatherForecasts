//
//  WeatherForecastsViewController.swift
//  DJWeatherProject
//
//  Created by linxian on 2017/2/20.
//  Copyright © 2017年 DogeJinx. All rights reserved.
//

import UIKit

class WeatherForecastsViewController: UIViewController {

    fileprivate var tableView: UITableView!
    fileprivate var bgImageView: UIImageView!
    fileprivate var cityName: String = "上海"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        self.navigationController?.navigationBar.setMyBackgroundColor(color: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0))
        
        bgImageView = UIImageView(frame: CGRect.zero)
        bgImageView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        view.addSubview(bgImageView)
        
        
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        tableHeaderView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = tableHeaderView
        
        
        let barBtn = UIBarButtonItem(title: "\(cityName)", style: .plain, target: self, action: #selector(WeatherForecastsViewController.dismissWFViewController))
        barBtn.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barBtn
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
    }

    func dismissWFViewController() {
        let animation = CATransition()
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction.init(name: "easeInEaseOut")
        animation.type = "moveIn"
        animation.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(animation, forKey: nil)
        self.dismiss(animated: true) { 
            
        }
    }
    
}


extension WeatherForecastsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12*2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "No.\(indexPath.row + 1)"
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("contentOffset: \(scrollView.contentOffset.y)")
        
        //NavBar及titleLabel透明度渐变
        let color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        let offsetY = scrollView.contentOffset.y
        let prelude: CGFloat = 50
        
        if offsetY >= 0 {
            let alpha = min(1, (0 + offsetY) / (0 + prelude))
            //NavBar透明度渐变
            self.navigationController?.navigationBar.setMyBackgroundColor(color: color.withAlphaComponent(alpha))
            
        } else {
            self.navigationController?.navigationBar.setMyBackgroundColor(color: color.withAlphaComponent(0))
        }
    }
    
}


var key: String = "coverView"

extension UINavigationBar {
    
    /// 定义的一个计算属性，如果可以我更希望直接顶一个存储属性。它用来返回和设置我们需要加到
    /// UINavigationBar上的View
    var coverView: UIView? {
        get {
            //这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回niu
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        
        set {
            //与上面对应是重新设置这个对象，最后一个参数如果学过oc的话很好理解，就是代表这个newValue的属性
            //OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func setMyBackgroundColor(color: UIColor) {
        
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), for: .topAttached, barMetrics: .default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: self.bounds.height + 20))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.insertSubview(view, at: 0)
            
            view.backgroundColor = color
            self.coverView = view
        }
    }
}

