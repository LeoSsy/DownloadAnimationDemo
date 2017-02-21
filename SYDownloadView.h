/**************************************************************************
 *
 *  Created by 舒少勇 on 2017/2/20.
 *    Copyright © 2017年 乔同新. All rights reserved.
 *
 * 项目名称：浙江踏潮-汇道-搏击项目
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>

@interface SYDownloadView : UIControl

/**线条的宽度*/
@property(nonatomic,assign)CGFloat lineWidth;

/**当前进度*/
@property(nonatomic,assign)CGFloat progress;

/**底圈颜色*/
@property(nonatomic,strong)UIColor *bgColor;

/**进度条颜色*/
@property(nonatomic,strong)UIColor *progressColor;

/**进度条值颜色*/
@property(nonatomic,strong)UIColor *progressValueColor;

@end
