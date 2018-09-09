#tag Window
Begin Window Main_Window
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   416
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   416
   MaximizeButton  =   True
   MaxWidth        =   316
   MenuBar         =   671768575
   MenuBarVisible  =   True
   MinHeight       =   416
   MinimizeButton  =   True
   MinWidth        =   316
   Placement       =   0
   Resizeable      =   False
   Title           =   "GA Pictures"
   Visible         =   True
   Width           =   316
   BeginSegmented SegmentedControl SegmentedControl1
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   17
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "Keep\n\nFalse\rDump\n\nFalse"
      SelectionType   =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   157
      Transparent     =   False
      Visible         =   True
      Width           =   128
   End
   BeginSegmented SegmentedControl SegmentedControl2
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   165
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "Keep\n\nFalse\rDump\n\nFalse"
      SelectionType   =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      Top             =   157
      Transparent     =   False
      Visible         =   True
      Width           =   128
   End
   BeginSegmented SegmentedControl SegmentedControl3
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   17
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "Keep\n\nFalse\rDump\n\nFalse"
      SelectionType   =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   335
      Transparent     =   False
      Visible         =   True
      Width           =   128
   End
   BeginSegmented SegmentedControl SegmentedControl4
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   165
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "Keep\n\nFalse\rDump\n\nFalse"
      SelectionType   =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      Top             =   335
      Transparent     =   False
      Visible         =   True
      Width           =   128
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  dim i,j,k as integer
		  dim new_ga_p as ga_picture
		  
		  for k = 0 to 3
		    new_ga_p = new ga_picture
		    
		    for i = 0 to 127
		      for j = 0 to 127
		        new_ga_p.picture(i,j) = rgb(rnd*255,rnd*255,rnd*255)
		      next
		    next
		    
		    ga_pictures_array.Append new_ga_p
		  next
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  dim i,j,k as integer
		  
		  for k = 0 to 3
		    dim p as new picture(128,128,32)
		    
		    for i = 0 to 127
		      for j = 0 to 127
		        p.RGBSurface.Pixel(i,j) = ga_pictures_array(k).picture(i,j)
		      next
		    next
		    
		    g.DrawPicture(p,148*(k mod 2)+20,178*(k \ 2)+20)
		  next
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		ga_pictures_array(-1) As ga_picture
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
