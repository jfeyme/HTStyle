# HTStyle
HTStyle - HTView - HTButton...
UI,可以很方便的布局,相对定位, 可替换系统的UIView等...

* 类似HTML JS代码的方式

# 做界面非常简单实用的一套HTView类... 有多种常用的布局View...

* 使用方法.
* 导入 HTStyle所有文件... 还用一个第三方框架: 导入到项目中: RZDataBinding
* 要用到时导入 #import "HTStyle.h" 就可以了
* 
*  HTView *view = [HTView new];
*  view.width = 100;
*  view.height = 100;
*  view.style.top = 20;
*  view.style.right = 20; //相对于父对象的定位, 靠右
*  [self.view addSubview:view];
