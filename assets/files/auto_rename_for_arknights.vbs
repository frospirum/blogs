'title - �����޸��ļ���(+_m)
'time  - 20200510

Dim fso, trashPath, appPath
Set fso = CreateObject("Scripting.FileSystemObject")
AppPath = Fso.GetFile(Wscript.ScriptFullName).ParentFolder.Path

' �ȴ���һ�������ļ��зŲ���ʶ����������
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
  
  ' �ж�ԭͼ�Ƿ����
  sImg = Replace(name,"[alpha].png",".png")
  If Not fso.FileExists(sImg) Then
    Exit Function
  End If
  
  Dim sW, sH
  Img.LoadFile sImg
  sW = Img.Width
  sH = Img.Height
  Img.LoadFile name
  ' ������Щ��С��ԭͼ��һ�µ�ͨ��ͼ�����޸�
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

MsgBox "�ļ��������������"