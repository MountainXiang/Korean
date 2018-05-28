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
        
        self.view.backgroundColor = UIColor.orange
        
        //Method 1 缺点：不能换行
        let bezierText = MTXBezierText.init(frame: CGRect.init(x: 0, y: self.view.bounds.size.height / 4, width: self.view.bounds.size.width, height: self.view.bounds.size.height / 4))
        bezierText.show(text: "世界，你好 我是项大山 My Name is 항대산\n slnslns hahahhah")
        view.addSubview(bezierText)
        
        //Method 2 缺点：不能换行；语言切换后绘制错乱
        self.test()
        
    }
    
    private func test() {
        // Create path from text
        // See: http://www.codeproject.com/KB/iPhone/Glyph.aspx
        // License: The Code Project Open License (CPOL) 1.02 http://www.codeproject.com/info/cpol10.aspx
        let letters = CGMutablePath()
        let font = CTFontCreateWithName("Helvetica-Bold" as CFString, 17.0, nil)
        let attrs = [NSAttributedStringKey.font : font]
        let attrString = NSAttributedString.init(string: "世界，你好 我是项大山 My Name is 항대산\n GGG", attributes: attrs)
        let line = CTLineCreateWithAttributedString(attrString)
        let glyphRuns = CTLineGetGlyphRuns(line)
        // for each RUN
        for runIndex in 0..<CFArrayGetCount(glyphRuns) {
            let run = CFArrayGetValueAtIndex(glyphRuns, runIndex);
            let runb = unsafeBitCast(run, to: CTRun.self)
            // Get FONT for this run
            let CTFontName = unsafeBitCast(kCTFontAttributeName,
                                           to: UnsafeRawPointer.self)
            let runFont = CFDictionaryGetValue(CTRunGetAttributes(runb), CTFontName)
            
            // for each GLYPH in run
            let glyphsNum = CTRunGetGlyphCount(runb)
            for glyphLoc in 0...glyphsNum {
                let glyphRange = CFRangeMake(glyphLoc, 1)
                let glyph = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
                CTRunGetGlyphs(runb, glyphRange, glyph)
                let position = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
                CTRunGetPositions(runb, glyphRange, position)
                
                // Get PATH of outline
                let runFontS = unsafeBitCast(runFont, to: CTFont.self)
                if let letter: CGPath = CTFontCreatePathForGlyph(runFontS, glyph.pointee, nil) {
                    let t : CGAffineTransform = CGAffineTransform(translationX: position.pointee.x, y: position.pointee.y)
                    letters.addPath(letter, transform: t)
                }
            }
        }
//        for run in glyphRuns as! Array<CTRun> {
//             // Get FONT for this run
//            let CTFontName = unsafeBitCast(kCTFontAttributeName,
//                                           to: UnsafeRawPointer.self)
//            let runFont = CFDictionaryGetValue(CTRunGetAttributes(run), CTFontName)
//
//            // for each GLYPH in run
//            let glyphsNum = CTRunGetGlyphCount(run)
//            for glyphLoc in 0...glyphsNum {
//                let glyphRange = CFRangeMake(glyphLoc, 1)
//                let glyph = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
//                CTRunGetGlyphs(run, glyphRange, glyph)
//                let position = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
//                CTRunGetPositions(run, glyphRange, position)
//
//                // Get PATH of outline
//                let runFontS = unsafeBitCast(runFont, to: CTFont.self)
//                if let letter: CGPath = CTFontCreatePathForGlyph(runFontS, glyph.pointee, nil) {
//                    let t : CGAffineTransform = CGAffineTransform(translationX: position.pointee.x, y: position.pointee.y)
//                    letters.addPath(letter, transform: t)
//                }
//            }
//        }
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.append(UIBezierPath(cgPath: letters))
        
        //初始化字迹图层
        pathLayer.frame = CGRect.init(x: 0, y: self.view.bounds.size.height / 2, width: self.view.bounds.size.width, height: self.view.bounds.size.height / 4)
        pathLayer.isGeometryFlipped = true
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.cgColor
        self.view.layer.addSublayer(pathLayer)
        
        //初始化钢笔图标图层
        let pen = #imageLiteral(resourceName: "pencil")
        penLayer.contents = pen.cgImage
        penLayer.anchorPoint = .zero
        penLayer.frame = CGRect(x: 0, y: 0, width: pen.size.width,
                                height: pen.size.height)
        
        //获取文字对应的贝塞尔曲线
        let textPath = bezierPath
        //让文字居中显示
        pathLayer.bounds = textPath.cgPath.boundingBox
        //设置笔记书写路径
        pathLayer.path = textPath.cgPath
        
        //添加笔迹书写动画
        let textAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        textAnimation.duration = Double(attrString.string.count) * velocity
        textAnimation.fromValue = 0
        textAnimation.toValue = 1
        textAnimation.repeatCount = drawRepeatCount
        pathLayer.add(textAnimation, forKey: "strokeEnd")
        
        //将钢笔图层添加到字迹图层中
        pathLayer.addSublayer(penLayer)
        
        //给钢笔图标添加移动动画
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.delegate = self
        orbit.duration = Double(attrString.string.count) * velocity
        orbit.path = textPath.cgPath
        orbit.calculationMode = kCAAnimationPaced
        orbit.isRemovedOnCompletion = false
        orbit.fillMode = kCAFillModeForwards
        orbit.repeatCount = drawRepeatCount
        penLayer.add(orbit,forKey:"position")
    }
    
    //钢笔移动动画播放结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //文字书写完毕后将钢笔移出
        penLayer.removeFromSuperlayer()
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
