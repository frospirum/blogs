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