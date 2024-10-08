# 某下落式音游脚本 电脑模拟器配合使用

自用下落式音游脚本, 第一次写脚本, 记录一下. 主要是py+按键精灵实现的.

## 使用环境

屏幕分辨率: 1440 * 900

屏幕缩放: 100%

模拟器启动游戏,开全屏

速度:2; 打歌背景:简易背景; 判定线:type2

## 使用方法

1. 进入歌曲**直至显示完歌曲信息** -> 按键精灵启动脚本(f10) -> 开始歌曲直至结束 -> 关闭脚本(f12)与python程序
2. 不可以随意点开脚本,不然屏幕大概率会乱点乱拖

## 主要功能与效果

1. 可以通过最简单难度的歌曲关卡,适合不追求分数的刷关.
2. 几乎能够正常识别所有单个点击以及所有音符. 
3. 遇到同时点击时,效果不佳, 成功率大概在30%.
4. Perfect : Great : Good的比例大约在13 : 4 : 1,bad与miss取决于同时点击的音符的数量.

## 脚本思路

1. 使用python开启遮罩层,把非判定区域的部分用深色/白色处理,以防颜色识别过早.
2. 再用按键精灵的功能, 通过两个线程同时监视屏幕的不同区域，识别特定颜色的像素。如果找到目标颜色，会根据颜色执行不同的鼠标操作（滑动或点击）

为什么选择使用遮挡层而不是逐一指定那七个点击区域的范围进行识别？因为我的电脑性能较低，如果在一秒钟内依次识别这七个区域并逐一处理，效率会非常低下，更别谈用七个线程同时处理的情况。经过尝试，发现将任务分成两个线程处理效果最好。目前我还没有找到更好的解决方案，如果有更好的建议，求指导.

## 需要调节的参数

![cover_description](cover_description.png)

Sub ProcessColor(x1, y1, x2, y2, colors, list1, list2)

其中(x1, y1, x2, y2)为需要识别的大区域,colors不用变,list1为点击区域的范围的列表,list2为点击区域对应的click坐标的列表,它们是一一对应的关系.

若分辨率不一样,需要设置:

1. 两个线程分别识别的区域范围(x1, y1, x2, y2)
2. 每个点击区的范围 (list1)
3. 每个点击区对应的click点击坐标 (list2)
4. 遮罩层的图片也要根据自己的分辨率重新画,截图修改即可.

Delay的参数可能需要依据每台电脑的执行效率灵活改变.



非科班音游人为了解放双手打活动自学的产物,还请多多指教!
