# stoneM
x86汇编实现显示个人信息和45度斜射的A

## 工具：
1.nasm http://www.nasm.us/pub/nasm/releasebuilds/2.13.03/win64/
2.vmware

## 基本原理：
用nasm将stoneM.asmsh生成stoneM.img，在vmware里面引导stoneM.img,于是完成了实验

## 使用方法：
先把上面的文件下载下来，然后按照下面的方法就好了
1.安装好nasm和vmware,双击nasm,输入下面的命令，注意改一下路径啊！！
```
nasm F:\操作系统\stoneM.asm -o F:\操作系统\stoneM.img
```
于是我们得到了一个.img文件

2.打开vmware,创建新的虚拟机->稍后安装操作系统->其他其他->……->自定义硬件->添加->选软盘驱动器->使用软盘映像（注意这里选择刚才生成的.img文件！！！！！）->开虚拟机运行

3.完成实验

## 代码解释：

其实用的就是老师给的代码，在前面加了一点东西来显示个人信息，原理ppt上面有讲，也可以参考这个博客 http://blog.csdn.net/longintchar/article/details/70183677
