//
//  JSRepository.h
//  PushProject
//
//  Created by lmg on 2019/6/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSRepository : NSObject
/*
 Git仓库目录是Git用来保存项目的元数据和对象数据库的地方，这是Git中最重要的部分，从其他计算机克隆仓库时，拷贝的就是这里的数据。
 
 工作目录是对项目的某个版本独立提取出来的内容，这些从Git仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。
 
 暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在Git仓库目录中，有时候也被称作索引，不过一般说法还是叫暂存区。
 
 1--------全局配置信息
 
 git config --global user.name luomengge
 git config --global user.email luomenge@cheyipai.com
 
 当你想针对特定项目使用不同的用户名称与邮件地址时，可以在那个项目目录下运行没有--global选项的命令来配置
 
 查看全局配置 git config --list
 
 2--------Git Clone
 
 git clone url
 自定义本地仓库的名字
 git clone url localName
 
 
 git status
 
 gitadd命令使用文件或目录的路径作为参数；如果参数是目录的路径，该命令将递归的跟踪该目录下的所有文件
 
 git只暂存了你运行git add命令时的版本，如果你在add以后，又修改了文件，需要重新运行git add把最新版本重新暂存起来
 
 git diff: 此命令比较的是工作目录中当前文件和暂存区域快照之间的差异，也就是修改之后还没有暂存起来的变化内容，只显示尚未暂存的改动
 
 git diff --staged/--cached:查看已暂存的将要添加到下次提交里的内容
 
 
 git commit -m "mark message"
 提交时记录的是放在暂存区域的快照，任何还未暂存的仍然保持已修改状态，可以在下次提交时纳入版本管理，每一次运行提交操作，都是对你项目做一次快照，以后可以回到这个状态，或者进行比较
 
 
 跳过使用暂存区域
 git commit -a -m""
 git会自动把所有已经跟踪过的文件暂存起来一起提交，从而跳过git add步骤
 
 rm PROJECTS.md  删除文件
 git rm PROJECTS.md 删除git文件管理
 
 
 git rm README.md README
           =
 mv  README.md   README
 git rm  README.md
 git add README
 
 
 git log -p -2
 git log --stat  每次提交的简略的统计信息
 git log --pretty=oneline  一行展示历史记录
 
 -n                      仅显示最近的n条提交
 --since,--after         仅显示指定时间之后的提交
 --until,--before        仅显示指定时间之前的提交
 --auther                仅显示指定作者相关的提交
 --committer             仅显示指定提交者相关的提交
 --grep                  仅显示含指定关键字的提交
 -S                      仅显示添加或移除了某个关键字的提交
 For Example
 git log --pretty="%h - %s"  --auther=gitster --since="2018-10-01" \
 --before="2018-11-01" --no-merges --t/
 
 覆盖上一次提交的结果：
 1.git commit -m"initial commit"
 2.git add forgotten_file
 3.git commit --amend
 最终你只会有一个提交，第二次提交将覆盖第一次提交的结果
 
 
 取消暂存的文件
 git reset HEAD CONTRIBUTING.md
 
 
 撤销对文件的修改
 git checkout --CONTRIBUTING.md
 (你只是拷贝了一个文件来覆盖他，除非你确实清楚不想要那个文件了，否则不要使用这个命令)
 
 
 查看远程仓库
 git remote
 git remote -v 会显示需要读写远程仓库使用的Git保存的简写与其对应的URL
 
 
 从远程仓库中抓取与拉取
 git fetch [remote-name]
 git pull
 (当你想要将master分支推送到origin服务器时，克隆时通常会自动帮你设置好那两个名字)
 
 
 查看远程仓库
 git remote show [remote-name]
 
 
 
 推送到远程仓库
 git push [remote-name] [branch-name]
 git push origin master
 
 
 
 
 
 文件状态：
 未跟踪
 
 
 已跟踪
 已修改  未修改
 
 
 暂存区
 
 已提交
 
 */

/*
 禁止.DS_store生成
 defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
 
 恢复.DS_store生成
 defaults delete com.apple.desktopservices DSDontWriteNetworkStores

 
 */

@end

NS_ASSUME_NONNULL_END
