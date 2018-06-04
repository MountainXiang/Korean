//
//  MTXPlusButton.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/6/4.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit
import CYLTabBarController

class MTXPlusButton: CYLPlusButton, CYLPlusButtonSubclassing {
    static func plusButton() -> Any! {
        let button = MTXPlusButton()
        button.setImage(UIImage(named: "post_normal"), for: .normal)
        button.titleLabel?.textAlignment = .center
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        button.setTitle("发布", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        
        button.setTitle("选中", for: .selected)
        button.setTitleColor(UIColor.blue, for: .selected)
        
        button.adjustsImageWhenHighlighted = false
        button.adjustsImageWhenDisabled = false
        
        button.sizeToFit()
        
//        button.addTarget(button, action: #selector(btnClicked(_:)), for: .touchUpInside)
        
        return button
    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 2
    }
    
    static func multiplier(ofTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 0.3
    }
    
    static func constantOfPlusButtonCenterYOffset(forTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return -10
    }
    
    /*!
     * 实现该方法后，能让 PlusButton 的点击效果与跟点击其他 TabBar 按钮效果一样，跳转到该方法指定的 UIViewController 。
     * @attention 必须同时实现 `+indexOfPlusButtonInTabBar` 来指定 PlusButton 的位置。
     * @return 指定 PlusButton 点击后跳转的 UIViewController。
     *
     */
    static func plusChildViewController() -> UIViewController! {
//        let vc = MTXMineRootViewController()
//        let nav = UINavigationController(rootViewController: vc)

        let nav = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent"))
        return nav
    }
    
    static func shouldSelectPlusChildViewController() -> Bool {
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // tabbar UI layout setup
        let imageViewEdgeWidth:CGFloat  = self.bounds.size.width * 0.7
        let imageViewEdgeHeight:CGFloat = imageViewEdgeWidth * 0.9
        
        let centerOfView    = self.bounds.size.width * 0.5
        let labelLineHeight = self.titleLabel!.font.lineHeight
        let verticalMargin = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight ) * 0.5
        
        let centerOfImageView = verticalMargin + imageViewEdgeHeight * 0.5
        let centerOfTitleLabel = imageViewEdgeHeight + verticalMargin * 2  + labelLineHeight * 0.5 + 10
        
        //imageView position layout
        self.imageView!.bounds = CGRect(x:0, y:0, width:imageViewEdgeWidth, height:imageViewEdgeHeight)
        self.imageView!.center = CGPoint(x:centerOfView, y:centerOfImageView)
        
        //title position layout
        self.titleLabel!.bounds = CGRect(x:0, y:0, width:self.bounds.size.width,height:labelLineHeight)
        self.titleLabel!.center = CGPoint(x:centerOfView, y:centerOfTitleLabel)
    }
    
    //MARK: Event Response
    @objc func btnClicked(_ btn: MTXPlusButton) {
        let tabBarController = self.cyl_tabBarController
        let vc = tabBarController?.selectedViewController
        
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction.init(title: "拍照", style: .default) { (action) in
            print(action.title as Any)
        }
        let action2 = UIAlertAction.init(title: "从相册选取", style: .default) { (action) in
            print(action.title as Any)
        }
        let action3 = UIAlertAction.init(title: "淘宝一键转卖", style: .default) { (action) in
            print(action.title as Any)
        }
        let action4 = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            print(action.title as Any)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        vc?.present(alert, animated: true, completion: {
            
        })
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
