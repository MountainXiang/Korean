//
//  MTXHomeRootViewController.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/5/9.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit

class MTXHomeRootViewController: UIViewController, CAAnimationDelegate {
    
    //字迹动画速度
    private let velocity:TimeInterval = 1.0
    
    //重复次数
    private let drawRepeatCount:Float = 0
    
    //字迹书写图层
    private let pathLayer = CAShapeLayer()
    
    //钢笔图标图层
    private var penLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let bezierText = MTXBezierText.init(frame: CGRect.init(x: self.view.bounds.size.width / 4, y: self.view.bounds.size.height / 4, width: self.view.bounds.size.width / 2, height: self.view.bounds.size.height / 4))
        bezierText.show(text: "돌아와서 환영합니다~")
//        bezierText.layer.borderColor = UIColor.brown.cgColor
//        bezierText.layer.borderWidth = 1.0
        view.addSubview(bezierText)
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
