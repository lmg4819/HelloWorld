//
//  main.m
//  HelloWordl
//
//  Created by lmg on 2019/4/28.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

struct BinaryTreeNode {
    int m_nValue;
    struct BinaryTreeNode *m_pleft;
    struct BinaryTreeNode *m_pright;
};
/*
 type               32        64       min   max
 char               1          1
 char *(指针变量)    4           8
 unsigned char      1          1
 short              2          2
 unsigned short     2          2
 int                4          4      2^32(-2147483648~~2147483647)
 unsigned int       4          4
 long               4          8      2^64(-9223372036854775808～9223372036854775807)
 long long          8          8      2^64
 unsigned long long 8          8      2^64
 float              4          4      6位小数
 double             8          8      15位小数
 */

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        printf("int 存储大小 : %lu \n", sizeof(long));
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
