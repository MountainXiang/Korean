//
//  MTXBezierText.swift
//  KoreanLearning
//
//  Created by 项大山 on 2018/5/12.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit

class MTXBezierText: UIView, CAAnimationDelegate {

    //单个字迹到动画时长
    private let velocity:TimeInterval = 0.5
    
    //重复次数
    private let drawRepeatCount:Float = 0
    
    //字迹书写图层
    private let pathLayer = CAShapeLayer()
    
    //钢笔图标图层
    private var penLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化字迹图层
        pathLayer.frame = self.bounds
        pathLayer.isGeometryFlipped = true
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(pathLayer)
        
        //初始化钢笔图标图层
        let pen = #imageLiteral(resourceName: "pencil")
        penLayer.contents = pen.cgImage
        penLayer.anchorPoint = .zero
        penLayer.frame = CGRect(x: 0, y: 0, width: pen.size.width,
                                height: pen.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //动态书写指定文字
    func show(text: String) {
        //获取文字对应的贝塞尔曲线
        let textPath = bezierPathFrom(string: text)
        //让文字居中显示
        pathLayer.bounds = textPath.cgPath.boundingBox
        //设置笔记书写路径
        pathLayer.path = textPath.cgPath
        
        //添加笔迹书写动画
        let textAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        textAnimation.duration = Double(text.count) * velocity
        textAnimation.fromValue = 0
        textAnimation.toValue = 1
        textAnimation.repeatCount = drawRepeatCount
        pathLayer.add(textAnimation, forKey: "strokeEnd")
        
        //将钢笔图层添加到字迹图层中
        pathLayer.addSublayer(penLayer)
        
        //给钢笔图标添加移动动画
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.delegate = self
        orbit.duration = Double(text.count) * velocity
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
    
    //将字符串转为贝塞尔曲线
    private func bezierPathFrom(string:String) -> UIBezierPath{
        let paths = CGMutablePath()
        //Helvetica-Bold  SnellRoundhand AmericanTypewriter-Bold
        let fontNameStr = "Helvetica-Bold"
        let fontName = __CFStringMakeConstantString(fontNameStr)!
        let fontSize:CGFloat = 22
        let fontRef:CTFont = CTFontCreateWithName(fontName, fontSize, nil)
        let font:UIFont = UIFont(name: fontNameStr, size: fontSize)!
        let lineSpace:CGFloat = 5
        
        let attrString = NSAttributedString(string: string, attributes:
            [kCTFontAttributeName as NSAttributedStringKey : fontRef])
        let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
        let runA = CTLineGetGlyphRuns(line)
        
        for runIndex in 0..<CFArrayGetCount(runA) {
            let run = CFArrayGetValueAtIndex(runA, runIndex);
            let runb = unsafeBitCast(run, to: CTRun.self)
            
            let CTFontName = unsafeBitCast(kCTFontAttributeName,
                                           to: UnsafeRawPointer.self)
            
            let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
            let runFontS = unsafeBitCast(runFontC, to: CTFont.self)
            
            let width = self.bounds.size.width
            
            for i in 0..<CTRunGetGlyphCount(runb) {
                let range = CFRangeMake(i, 1)
                let glyph = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
                glyph.initialize(to: 0)
                let position = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
                position.initialize(to: .zero)
                CTRunGetGlyphs(runb, range, glyph)
                CTRunGetPositions(runb, range, position);
                
                //Automatic Linebreak
                let lineH = "test".stringHeightWith(font: font, width: width, lineSpace: lineSpace)
                
                if let path = CTFontCreatePathForGlyph(runFontS,glyph.pointee,nil) {
                    let x = position.pointee.x.truncatingRemainder(dividingBy: width)
                    let y = position.pointee.y - floor(position.pointee.x / width) * lineH
                    let transform = CGAffineTransform(translationX: x, y: y)
                    paths.addPath(path, transform: transform)
                }
               
                /*
                 Removing capacity from deallocate(capacity:) will end the confusion over what deallocate() does, making it obvious that deallocate() will free the entire memory block at self, just as if free() were called on it.
                 
                 The old deallocate(capacity:) method should be marked as deprecated and eventually removed since it currently encourages dangerously incorrect code.
                 
                 refer to:
                 https://github.com/apple/swift-evolution/blob/master/proposals/0184-unsafe-pointers-add-missing.md
                 */
//                glyph.deinitialize()
//                glyph.deallocate(capacity: 1)
                glyph.deinitialize(count: 1)
                glyph.deallocate()
                
//                position.deinitialize()
//                position.deallocate(capacity: 1)
                position.deinitialize(count: 1)
                position.deallocate()
            }
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.append(UIBezierPath(cgPath: paths))
        
        /*
         The Working with Cocoa Data Types section of Using Swift with Cocoa and Objective-C says
         https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html
         (emphasis mine):
         
         Core Foundation objects returned from annotated APIs are automatically memory managed in Swift—you do not need to invoke the CFRetain, CFRelease, or CFAutorelease functions yourself. If you return Core Foundation objects from your own C functions and Objective-C methods, annotate them with either CF_RETURNS_RETAINED or CF_RETURNS_NOT_RETAINED.
         
         …
         
         When Swift imports APIs that have not been annotated, the compiler cannot automatically memory manage the returned Core Foundation objects. Swift wraps these returned Core Foundation objects in an Unmanaged<T> structure.
         
         So we remove release calls like these:
         CFRelease(line);
         CGPathRelease(letters);
         CFRelease(font);
         */
        
        return bezierPath
    }

}
