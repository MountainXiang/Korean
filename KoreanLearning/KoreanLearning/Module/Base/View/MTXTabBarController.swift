//
//  MTXTabBarController.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/5/9.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit

class MTXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        let homeVc = MTXHomeRootViewController()
        let listenVc = MTXListenRootViewController()
        let watchVc = MTXWatchRootViewController()
        let mineVc = MTXMineRootViewController()
        self.viewControllers = [homeVc, listenVc, watchVc, mineVc]
        
        homeVc.tabBarItem.title = "首页"
        listenVc.tabBarItem.title = "听听"
        watchVc.tabBarItem.title = "看看"
        mineVc.tabBarItem.title = "我的"
        
        homeVc.tabBarItem.image = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysOriginal)
        listenVc.tabBarItem.image = #imageLiteral(resourceName: "cloudy").withRenderingMode(.alwaysOriginal)
        watchVc.tabBarItem.image = #imageLiteral(resourceName: "thundershower").withRenderingMode(.alwaysOriginal)
        mineVc.tabBarItem.image = #imageLiteral(resourceName: "rainy").withRenderingMode(.alwaysOriginal)
        
        homeVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "sunny").withRenderingMode(.automatic)
        listenVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "cloudy").withRenderingMode(.automatic)
        watchVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "thundershower").withRenderingMode(.automatic)
        mineVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "rainy").withRenderingMode(.automatic)
        
        self.tabBar.tintColor = UIColor.brown
        
        self.tabBarController?.selectedViewController = homeVc
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
