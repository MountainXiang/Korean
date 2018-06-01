//
//  MTXListenRootViewController.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/5/9.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit

class MTXListenRootViewController: UIViewController {
    
    //动态修改的icon不能放在 Assets.xcassets 里
    private let icons = ["redIcon","blueIcon","blackIcon"]
    
    //在参数名前添加下划线来忽略外部参数名
    @objc private func alternateIcon(_ button : UIButton) {
        let tag = button.tag
        
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                UIApplication.shared.setAlternateIconName(icons[tag]) { (error) in
                    if ((error) != nil) {
                        print(error?.localizedDescription as Any)
                    } else {
                        print("alternateIconSuccess:" + self.icons[tag])
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            print("Warning:your application cannot change icons!")
        }
    }
    
    @objc private func backToPrimaryIcon(_ button:UIButton) {
        if #available(iOS 10.3, *) {
            if (UIApplication.shared.alternateIconName != nil) {
                UIApplication.shared.setAlternateIconName(nil) { (error) in
                    if ((error) != nil) {
                        print(error?.localizedDescription as Any)
                    } else {
                        print("backToPrimaryIconSuccess")
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            print("Warning:your application cannot change icons!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let btnW : CGFloat = 200
        let btnH : CGFloat = 50
        let btnMargin : CGFloat = 50
        for i in 0..<3 {
            let btn = UIButton(frame: CGRect(x: (SCREEN_WIDTH - btnW) / 2, y: btnMargin * (CGFloat(i) + 1) + CGFloat(i) * btnH, width: btnW, height: btnH))
            view.addSubview(btn)
            btn.tag = i
            btn.setTitle(icons[i], for: .normal)
            btn.addTarget(self, action: #selector(alternateIcon(_:)), for: .touchUpInside)
            btn.backgroundColor = UIColor.orange
        }
        
        let btn = UIButton(frame: CGRect(x: (SCREEN_WIDTH - btnW) / 2, y: btnMargin * 4 + 3 * btnH, width: btnW, height: btnH))
        btn.setTitle("backToPrimaryIcon", for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(backToPrimaryIcon(_:)), for: .touchUpInside)
        btn.backgroundColor = UIColor.green
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

}
