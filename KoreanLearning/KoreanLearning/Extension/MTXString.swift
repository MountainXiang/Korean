//
//  MTXString.swift
//  KoreanLearning
//
//  Created by 项大山 on 2018/5/29.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit

extension String{
    
    //MARK: 计算字符串高度
    
    func stringHeightWith(font:UIFont,width:CGFloat,lineSpace : CGFloat)->CGFloat{
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpace
        
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedStringKey.font:font, NSAttributedStringKey.paragraphStyle:paragraphStyle]
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }
    
}
