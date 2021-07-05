---
title: 关于 VMware Workstation 和 Hyper-V 的冲突问题
tags: technique
show_edit_on_github: false
modify_date: 2021-03-18
---

日常踩坑

<!--more-->

最近在折腾虚拟化的时候遇到了一些问题，在这里记录一些心得。由于本人并不使用 VirtualBox，因此这里以 VMware Workstation 为例。

今天遇到了广大人民群众喜闻乐见的 VMware Workstation 和 Hyper-V 的冲突问题，启动时显示“在此主机上不支持嵌套虚拟化”。记得这个问题在15.5.5就已经解决，遂查询 Release Notes（事实证明我没记错）：

> 支持 Windows 10 主机 VBS：  现在，VMware Workstation 15.5.5 可在启用了 Hyper-V 功能（例如：基于虚拟化的安全性）的 Windows 主机上运行。 
>
> 以下是在启用了 Hyper-V 的主机上运行 VMware Workstation 的最低要求：
>
> CPU 要求：
>
> Intel Sandy Bridge 或更新的 CPU
>
> AMD Bulldozer 或更新的 CPU
>
> 支持的主机操作系统：
>
> Windows 10 20H1 内部版本 19041.264 或更新版本
>
> 支持新的客户机操作系统：
>
> Windows 10 20H1
>
> Ubuntu 20.04
>
> Fedora 32
>
> 支持新的主机操作系统：
>
> Windows 10 20H1
>
> Ubuntu 20.04

然而并没有什么卵用，软硬件均符合要求，但还是报错......

又经过一番查找得到了解决方法：关闭CPU虚拟化。

问题得到了解决，然而基于 VBox 的 Android 模拟器仍然无法启动，需要关闭 Hyper-V 功能和服务。这就引出了一些问题：VMware Workstation 和 Hyper-V 为什么冲突，Workstation 15.5.5 对 Hyper-V 的兼容为何需要通过关闭CPU虚拟化实现？

实际上，Hyper-V 是一个 Type-1 的 Hypervisor，这时 Hyper-V 位于硬件层和 Windows 应用层之间，直接在主机的硬件上运行，以控制硬件和管理来宾操作系统。也就是说启用之后，主机操作系统也会在 Hyper-V 虚拟化层的顶部运行。

而 VMWare Workstation 是一个 Type-2 的 Hypervisor ，以特权模式运行，直接访问CPU以及访问CPU的内置虚拟化支持。 VMWare Workstation 与其他计算机程序一样，在常规操作系统上运行。当Windows主机启用 Hyper-V 后，系统将在硬件层和 Windows 应用层之间添加 Hyper-V 管理程序层。相当于主机操作系统也被虚拟化了[^1]，而 VMWare Workstation 并不能在这样的虚拟化环境下运行。

看起来冲突问题似乎没有什么解决的办法，那么 VMWare Workstation 是如何实现与 Hyper-V 的兼容呢？

其实问题仍未得到解决，只不过 VMware 采用了“曲线救国”的方法：通过调用 Windows Hypervisor Platform API 实现虚拟化，而不是直接使用基础硬件。当检测到主机系统开启 Hyper-V 后虚拟机其实是通过 Hyper-V 来运行的。VMware Workstation 变成了一个壳，而不再是采用自己的那一套虚拟化的方式。

简单来说就是看到的东西没换，运行虚拟机的虚拟化引擎已经被换掉了，虚拟化实质上只是在调用系统的 API ，这个时候工作的的其实只有 Hyper-V，所以就不存在冲突问题了。不过正是因为这样，基于VMware Workstation 原有引擎的CPU虚拟化也用不了了。

至此问题终于得到了解决。

[^1]:需要注意的是，被虚拟化的主机系统并不完全等同于虚拟机，主机操作系统可以直接访问所有硬件并具有 Hyper-V 的管理权限。

>参考资料：
>
>https://en.wikipedia.org/wiki/Hypervisor
>
>https://docs.microsoft.com/zh-cn/virtualization/hyper-v-on-windows/about
>
>https://docs.microsoft.com/en-us/virtualization/api
>
>https://blogs.vmware.com/workstation/2020/05/vmware-workstation-now-supports-hyper-v-mode.html
>
>https://docs.vmware.com/cn/VMware-Workstation-Pro/15.5/rn/VMware-Workstation-1555-Pro-Release-Notes.html
