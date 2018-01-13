# CustomKeyboard_iOS
近日项目需求，需要做自定义键盘，因为项目对安全性能要求较高，所以摒弃了系统键盘和一系列的第三方键盘，仿照工商银行app的键盘写了一个自定义键盘的demo，因为之前有很多的前辈留下足迹，所以做起来也不是很费力，在这里要感谢所有知识分享者，我不是巨人，我只是知识的搬运工，言归正传，在本demo里面，键盘布局并没有使用xib和storyboard，纯代码布局，至于因为什么。。。。。。我想你懂得！先来看一下效果图，请自动忽略比较丑的样子，主要看实现思路
想让UITextView弹出自己的键盘而不是系统键盘其实很简单，只需要一句代码即可

self.textView.inputView= keyboard;

剩下的就是自定义键盘view，分几个部分：

1、键盘类型切换按钮布局

//创建三种键盘切换button

- (void)configKeyboardType

{

NSIntegerbtnTypeCount =3;

CGFloatbtnWidth = (DeviceWidth/2)/btnTypeCount;

CGFloatbtnHeight =20;

NSArray*titles =@[@"数字",@"字母",@"符号"];

for(NSIntegeri =0; i < btnTypeCount; i++)

{

UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

btn.frame=CGRectMake((DeviceWidth/2)+i*btnWidth,5, btnWidth, btnHeight);

[btnsetTitle:titles[i] forState:UIControlStateNormal];

[btnsetTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

[btnsetTitleColor:[UIColor blueColor] forState:UIControlStateSelected];

btn.tag= (CustomKeyboardType)i+1;

if(i ==1)

{

//默认字母键盘

btn.selected=YES;

}

[btnaddTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

[selfaddSubview:btn];

}

}

//点击切换键盘

- (void)typeBtnClicked:(UIButton*)sender

{

if(sender.selected)

{

return;

}

UIButton *btn_num = [self viewWithTag:CustomKeyboardType_Num];

UIButton *btn_let = [self viewWithTag:CustomKeyboardType_Letters];

UIButton *btn_sym = [self viewWithTag:CustomKeyboardType_Symbol];

sender.selected=YES;

if(sender == btn_num)

{

btn_let.selected=NO;

btn_sym.selected=NO;

[self clickNumTypeBtn];

}

if(sender == btn_let)

{

btn_num.selected=NO;

btn_sym.selected=NO;

[self clickLetterTypeBtn];

}

if(sender == btn_sym)

{

btn_num.selected=NO;

btn_let.selected=NO;

[self clickSymbleTypeBtn];

}

}

2、三种键盘布局，也是采用的自定义view来封装

[self configNumKeyBoard];

[self configLetterKeyboard];

[self configSymbolKeyboard];

三种键盘全部继承一个基类PwKeyboardBaseView，里面包含了点击普通按键、删除按键、确认按键的block回调

@property(nonatomic,copy)void(^btnClickedCallback)(UIButton*btn);

@property(nonatomic,copy)void(^deleteBtnClickedCallback)(void);

@property(nonatomic,copy)void(^returnBtnClickedCallback)(void);

其中数字键盘做了乱序，只需要将装载所有数字的数组做乱序即可

_allNums = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];

_allNums = [_allNums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

intseed =arc4random_uniform(2);

if(seed) {

return[obj1compare:obj2];

}else{

return[obj2compare:obj1];

}

}];

思路就是将所有的数字、字母、符号全装在一个数组之中，再按行来拆分成若干数组，作为按钮标题

代码比较简单，也不再多介绍
