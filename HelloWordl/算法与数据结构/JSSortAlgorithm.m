//
//  JSSortAlgorithm.m
//  HelloWordl
//
//  Created by lmg on 2019/4/30.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSSortAlgorithm.h"

@implementation JSSortAlgorithm
-(instancetype)init
{
    self = [super init];
    if (self) {
        //        [self insertSort];
        //        [self popSort];
        //        [self selectSort];
        //        [self quickSort];
        //        [self heapSort];
        [self mergeSort];
        //        [self findTargetFromArray];
    }
    return self;
}

/*插入排序 时间复杂度n2
 5 3 4 8 7 6
 {3 5} 4 8 7 6
 {3 4 5} 8 7 6
 {3 4 5 8} 7 6
 {3 4 5 7 8} 6
 {3 4 5 6 7 8}
 
 */
- (void)insertSort
{
    NSMutableArray *array = @[@5,@3,@4,@8,@7,@6].mutableCopy;
    for (int i=1; i<array.count; i++) {
        NSNumber *temp = array[i];
        for (int j = i-1; j >= 0; j--) {
            if ([array[j] intValue] > [temp intValue]) {
                array[j+1] = array[j];
                array[j] = temp;
            }
        }
    }
    NSLog(@"---%@----",array);
}
/*冒泡排序 时间复杂度n2
 5 3 4 8 7 6
 3 5 4 8 7 6
 3 4 5 8 7 6
 3 4 5 7 8 6
 3 4 5 7 6 8
 */
- (void)popSort{
    NSMutableArray *array = @[@5,@3,@4,@8,@7,@6].mutableCopy;
    for (int i=0; i<array.count-1; i++) {
        for (int j=0; j<array.count-i-1; j++) {
            if ([array[j] intValue] > [array[j+1] intValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"---%@----",array);
}
/*选择排序 时间复杂度n2
 5 3 4 8 7 6
 3 5 4 8 7 6
 3 4 5 8 7 6
 3 4 5 6 7 8
 
 */
- (void)selectSort
{
    NSMutableArray *array = @[@5,@3,@4,@8,@7,@6].mutableCopy;
    for (int i=0; i<array.count-1; i++) {
        for (int j=i+1; j<array.count; j++) {
            if ([array[i] intValue] > [array[j] intValue]) {
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"---%@----",array);
}
/*快速排序 时间复杂度nlogn 最快的
 5 3 4 2 8 7 6    5 i=0 j=6
 2 3 4 2 8 7 5    5 i=0 j=3
 2 3 4 2 8 7 5    5 i=3 j=3
 2 3 4 5 8 7 5
 
 
 
 8 7 5 9 6 4 3  8 i=0 j=6
 3 7 5 9 6 4 3  8 i=0 j=6
 3 7 5 9 6 4 9  8 i=3 j=6
 3 7 5 4 6 4 9  8 i=3 j=5
 3 7 5 4 6 4 9  8 i=5 j=5
 3 7 5 4 6 8 9
 
 */
- (void)quickSort
{
    NSMutableArray *array = @[@8,@7,@5,@9,@6,@4,@3].mutableCopy;
    [self quick_sort:array left:0 right:(int)array.count-1];
    NSLog(@"----%@----",array);
}

- (void)quick_sort:(NSMutableArray *)array left:(int)left right:(int)right
{
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    NSNumber *temp = array[left];
    while (i<j) {
        while (i<j && [temp intValue] <= [array[j] intValue]) {
            j--;
        }
        array[i] = array[j];
        
        while (i<j &&  [temp intValue] >= [array[i] intValue] ) {//左边
            i++;
        }
        array[j] = array[i];
    }
    
    array[i] = temp;
    [self quick_sort:array left:left right:i-1];
    [self quick_sort:array left:i+1 right:right];
    
}
/*
 
 
 */

- (void)heapSort
{
    NSMutableArray *array = @[@5,@3,@4,@8,@7,@6].mutableCopy;
    //构建大顶堆
    for (int i=(int)array.count/2-1; i>=0; i--) {
        //从第一个非叶子节点从下至上，从右向左调整结构
        [self adjustHeap:array index:i length:(int)array.count];
    }
    //2.调整堆结构+交换堆顶元素与末尾元素
    for (int j=(int)array.count-1; j>0; j--) {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:j];
        [self adjustHeap:array index:0 length:j];
    }
    NSLog(@"----%@----",array);
    
}


- (void)adjustHeap:(NSMutableArray *)array index:(int)index length:(int)length
{
    int temp = [array[index] intValue];
    for (int k=index*2+1; k<length; k=k*2+1) {//从i结点的左子结点开始，也就是2i+1处开始
        if (k+1<length && [array[k] intValue] < [array[k+1] intValue]) {//如果左子结点小于右子结点，k指向右子结点
            k++;
        }
        if ([array[k] intValue] > temp) {//如果子节点大于父节点，将子节点值赋给父节点（不用进行交换）
            array[index] = array[k];
            index = k;
        }else{
            break;
        }
    }
    array[index] = @(temp);//将temp值放到最终的位置
}


/*
 二分查找
 */
- (void)findTargetFromArray
{
    NSArray *array = @[@2,@3,@4,@6,@8,@9];
    int result =  [self indexOfArray:array left:0 right:5 data:8];
    NSLog(@"--%d---",result);
}

- (int)indexOfArray:(NSArray *)array left:(int)left right:(int)right data:(int)data
{
    if (left < right) {
        int mid = (left + right)/2;
        if ([array[mid] intValue] < data) {
            return [self indexOfArray:array left:mid+1 right:right data:data];
        }else if([array[mid] intValue] > data){
            return [self indexOfArray:array left:left right:mid-1 data:data];
        }else{
            return mid;
        }
    }
    return -1;
}

- (void)mergeSort
{
    NSMutableArray *array = @[@2,@4,@3,@5,@1,@8,@7,@6].mutableCopy;
    NSMutableArray *resultArray = [NSMutableArray array];
    //在排序前，先建好一个长度等于原数组长度的临时数组，避免递归中频繁开辟空间
    [self sortArray:array left:0 right:(int)array.count-1 resultArray:resultArray];
    
}

- (void)sortArray:(NSMutableArray *)array left:(int)left right:(int)right resultArray:(NSMutableArray *)resultArray
{
    if (left < right) {
        int mid = (left + right)/2;
        [self sortArray:array left:left right:mid resultArray:resultArray];
        //左边归并排序，使得左子序列有序
        [self sortArray:array left:mid+1 right:right resultArray:resultArray];
        //右边归并排序，使得右子序列有序
        [self mergeArray:array left:left mid:mid right:right resultArray:resultArray];
        //将两个有序子数组合并操作
    }
}

- (void)mergeArray:(NSMutableArray *)array left:(int)left mid:(int)mid right:(int)right resultArray:(NSMutableArray *)resultArray
{
    int i = left;
    int j = mid + 1;
    int t = 0;
    while (i<=mid && j<=right) {
        if ([array[i] intValue] <= [array[j] intValue]) {
            resultArray[t++] = array[i++];
        }else{
            resultArray[t++] = array[j++];
        }
    }
    while (i<=mid) {//将左边剩余元素填充进temp中
        resultArray[t++] = array[i++];
    }
    while (j<=right) {//将右序列剩余元素填充进temp中
        resultArray[t++] = array[j++];
    }
    t = 0;
    //将temp中的元素全部拷贝到原数组中
    while(left <= right){
        array[left++] = resultArray[t++];
    }
    NSLog(@"----%@----%@",resultArray,array);
    
}


@end
