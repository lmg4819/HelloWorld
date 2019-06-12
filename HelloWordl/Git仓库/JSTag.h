//
//  JSTag.h
//  PushProject
//
//  Created by lmg on 2019/6/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSTag : NSObject
/*
 列出标签
 git tag
 
 后期打标签
 git tag v1.2 commitId
 
 共享标签
 git push origin v1.2
 git push origin --tags
 
 
 删除标签
 git tag -d v1.2
 git push origin :refs/tags/v1.2
 
 
 
 */
@end

NS_ASSUME_NONNULL_END
