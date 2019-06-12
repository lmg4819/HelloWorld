//
//  SectionFive.h
//  PushProject
//
//  Created by lmg on 2019/5/22.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionFive : NSObject
/*
 通常基于递归的实现方法代码会比较简洁，但性能不如基于循环的实现方法
 递归由于是函数调用自身，而函数调用是有空间和时间的消耗的，每一次函数调用，都需要在内存栈中分配空间以保存参数，返回地址和临时变量，并且往栈里压入数据和弹出数据都需要时间。
 
 
 二分查找，归并排序和快速排序
 动态规划
 
 位运算可以看成一种特殊的算法，它是把数字表示成二进制之后对0和1的操作
 与，或，异或，左移，右移三种运算
 */
@end

NS_ASSUME_NONNULL_END
