//
//  DimensMacro.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/5/31.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

//import Foundation
import UIKit

//MARK: 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

//MARK: 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//MARK: 状态栏高度
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height == 0 ? 20 : UIApplication.shared.statusBarFrame.size.height

//MARK: 导航栏高度
let NAVIGATION_BAR_HEIGHT: CGFloat = 44

//MARK: 头部高度
let TOP_BAR_HEIGHT = STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT

//MARK: TabBar高度
let TAB_BAR_HEIGHT: CGFloat = 49

//MARK: iPhone X竖屏时的safeAreaInsets
let IPHONEX_SAFEAREA_INSETS_PORTRAIT = UIEdgeInsetsMake(44, 0, 34, 0)

//MARK: iPhone X横屏时的safeAreaInsets
let IPHONEX_SAFEAREA_INSETS_LANSCAPE = UIEdgeInsetsMake(0, 44, 21, 44)

//MARK: 一像素的线
let SINGLE_LINE_HEIGHT: CGFloat = (1/UIScreen.main.scale)


