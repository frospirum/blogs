---
title: 小刻都也能看懂的解包教程
tags: technique
show_edit_on_github: false
modify_date: 2021-08-28
---

<!--more-->
>声明：
>本教程以明日方舟作为教程用例，所用到的工具及方法不保证适用于其他情况
>本教程纯粹兴趣使然，所涉及的公司名称、商标、产品等均为其各自所有者的资产，仅供识别。
>教程内使用的游戏图片、动画、音频、文本原文，仅用于更好地描述教程所述内容，其版权属于上海鹰角网络科技有限公司。
>请勿以任何形式传播此教程，也不要将利用此教程获取到的资源用于任何未经版权方允许的用途。所造成的后果由违规者自行承担，本站所有者不承担任何人士的违规行为所引致的任何赔偿。
>以上注意事项适用于后续所有涉及第三方资源的教程，使用此教程者视为自愿接受以上声明的约束，之后不再另附。

##### 获取资源

数据分为两部分，不需要安装后额外下载的数据可以在[官网](https://ak.hypergryph.com/downloads/android_lastest)下载安装包，将拓展名由`.apk`改为`.zip`，解压并提取`assets\AB\Android`目录。

需要额外下载的数据可以在**游戏下载并解压数据包后**从`/sdcard/Android/data/com.hypergryph.arknights/files/AB/Android`目录下获取。

##### 工具的介绍与获取

> AssetStudio is a tool for exploring, extracting and exporting assets and assetbundles.   
> [下载地址](https://github.com/Perfare/AssetStudio/releases) 
> [作者Blog](https://www.perfare.net/)

![image-20210828123848037](C:\Users\Oblisetta\AppData\Roaming\Typora\typora-user-images\image-20210828123848037.png)

以 v0.16.0 为例，下载`AssetStudio.v0.16.0.zip`并解压，双击 AssetStudioGUI.exe 启动软件。

![image-20210828124757095](C:\Users\Oblisetta\AppData\Roaming\Typora\typora-user-images\image-20210828124757095.png)

##### 资源提取

- 运行`AssetStudioGUI.exe` -> `File` -> `Load folder` -> 选择`Android `文件夹-> 等待文件载入

- 点击 `Filter Type`，会出现多个类型，这里挑几个来说

>AudioClip: 音乐
>Mesh: 实体模型
>Sprite: 一种特殊的图片，可以像普通的3D游戏物体一样对待
>Texture2D: 二维图片
>MonoBehaviour: Unity 脚本基类
>TextAsset: 文本对象

- 点击`Export` -> `Filtered assets` -> 导出所筛选资源

至此我们就获得了游戏内的资源。至于里面都有什么，各部分分别放在在哪里，各位自己去翻一翻就知道了。下面单独列出几种素材的二次处理。

##### 立绘

立绘位于提取出的一堆素材中名为`Texture2D`的文件夹下，但是我们发现这些立绘都被拆分成一张图 + 一个白底的形式，需要把它合成到一起。方法有很多种，这里采用GalPhotoAuto来处理。[下载地址](https://blog.ztjal.info/?dl_id=10)

- 新建一个txt文件，把以下代码复制进去并以`GB2312`编码保存，将拓展名由`.txt`改为`.vbs`，当然也可以点这里直接下载现成的脚本

```vbscript
'title - 批量修改文件名(+_m)
'time  - 20200510

Dim fso, trashPath, appPath
Set fso = CreateObject("Scripting.FileSystemObject")
AppPath = Fso.GetFile(Wscript.ScriptFullName).ParentFolder.Path

' 先创建一个无用文件夹放不能识别人物立绘
trashPath = AppPath & "\0_YouCanDel\"
If Fso.FolderExists(trashPath) = False Then
  Call Fso.CreateFolder(trashPath)
End If

Dim File, oFiles, I
Dim Img, IP
Set Img = CreateObject("WIA.ImageFile")
Set IP = CreateObject("WIA.ImageProcess")
IP.Filters.Add IP.FilterInfos("Scale").FilterID

Public Function find(ByVal file)
  Dim name, sImg
  name = File
  newname = Replace(name,"[alpha].png","_m.png")
  
  If InStrRev(name, "[alpha].png") = 0 Then 
    Exit Function
  End If
  
  ' 判断原图是否存在
  sImg = Replace(name,"[alpha].png",".png")
  If Not fso.FileExists(sImg) Then
    Exit Function
  End If
  
  Dim sW, sH
  Img.LoadFile sImg
  sW = Img.Width
  sH = Img.Height
  Img.LoadFile name
  ' 对于那些大小与原图不一致的通道图进行修改
  If (sW > Img.Width) Or (sH > Img.Height) Then
    IP.Filters(1).Properties("MaximumWidth") = sW
    IP.Filters(1).Properties("MaximumHeight") = sH
    IP.Apply(Img).SaveFile newname
    Fso.DeleteFile name
    Exit Function
  End If
  
  Fso.MoveFile File, newname
End Function

For Each File In Fso.GetFolder(AppPath).Files
  If Not find(File) Then
    'Fso.MoveFile File, trashPath & File.Name
  End If
Next

MsgBox "文件重命名处理完成"
```

- 将要合并的立绘的两张图放到同一个文件夹下（可以同时放多个人物的立绘），把脚本文件放到这个文件夹里并运行，处理成功后会弹出“文件重命名处理完成”消息，这时每个人物的立绘都被修改成了`xxx.png`和`xxx_m.png`的格式。

- 将之前下载的 GalPhotoAuto 解压后运行`GalPhotoAutoB.exe`，点击`(2)添加处理图片`把立绘所在文件夹拖到 `模式二（添加文件夹）` 下面的框里 
- 点击`(2)选择合成规则` ->`常规合成规则` -> `源图和ALPHA分开为两张图 `选中 `模式二：添加文件夹，自动合成，以"_m"结尾的合成， xxx.bmp是源图，xxx_m.bmp是作为ALPHA`然后点击`执行`两张图就被合并为一个完整的立绘。

###### 音频

语音和BGM都在`AudioClip`文件夹里，没什么好说的。值得注意的是为了能让 BGM 循环起来，音频被拆成了`xxx_intro.wav` 和`xxx_loop.wav`两部分，把这两部分拼起来即可。



