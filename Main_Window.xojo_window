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
   BeginSegmented SegmentedControl KeepDump
      Enabled         =   True
      Height          =   20
      Index           =   0
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
   BeginSegmented SegmentedControl KeepDump
      Enabled         =   True
      Height          =   20
      Index           =   1
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
   BeginSegmented SegmentedControl KeepDump
      Enabled         =   True
      Height          =   20
      Index           =   2
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
   BeginSegmented SegmentedControl KeepDump
      Enabled         =   True
      Height          =   20
      Index           =   3
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
   Begin PushButton EvolveButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Evolve"
      Default         =   False
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   216
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   376
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  dim i,j,k as integer
		  dim new_ga_p as ga_picture
		  
		  keepIndex = -1
		  dumpIndex = -1
		  
		  for k = 0 to 3
		    new_ga_p = new ga_picture
		    
		    for i = 0 to 127
		      for j = 0 to 127
		        new_ga_p.picture(i,j) = rgb(rnd*256,rnd*256,rnd*256)
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


	#tag Method, Flags = &h0
		Function closest_neighbour(pic as ga_picture, x as integer, y as integer) As color
		  dim diff,min_diff as integer
		  dim return_colour as color
		  
		  min_diff = 256
		  
		  if x-1 > -1 and y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y-1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x-1,y-1)
		    end
		  end
		  if x-1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x-1,y)
		    end
		  end
		  if x-1 > -1 and y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 128 and y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 128 and y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y-1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x+1,y-1)
		    end
		  end
		  if y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y-1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x,y-1)
		    end
		  end
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function colour_diff(c1 as Color, c2 as Color) As integer
		  return abs(c1.Red-c2.Red)+abs(c1.green-c2.green)+abs(c1.blue-c2.blue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve(evolve_method as integer, p1 as ga_picture, p2 as ga_picture) As ga_picture
		  Select case evolve_method
		  case 1
		    return evolve1(p1,p2)
		  case 2
		    return evolve2(p1,p2)
		  case 3
		    return evolve3(p1,p2)
		  case 4
		    return evolve4(p1,p2)
		  case 5
		    return evolve5(p1,p2)
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve1(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim i,j as integer
		  dim return_pic As new ga_picture
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      if rnd < 0.5 then
		        return_pic.picture(i,j) = p1.picture(i,j)
		      else
		        return_pic.picture(i,j) = p2.picture(i,j)
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve2(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim i,j as integer
		  dim return_pic As new ga_picture
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      if neighbours_diff(p1,i,j) < neighbours_diff(p2,i,j) then
		        return_pic.picture(i,j) = p1.picture(i,j)
		      else
		        return_pic.picture(i,j) = p2.picture(i,j)
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve3(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim c1,c2 as color
		  dim i,j as integer
		  dim return_pic As new ga_picture
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      c1 = closest_neighbour(p1,i,j)
		      c2 = closest_neighbour(p2,i,j)
		      if colour_diff(p1.picture(i,j),c1) < colour_diff(p2.picture(i,j),c2) then
		        return_pic.picture(i,j) = c1
		      else
		        return_pic.picture(i,j) = c2
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve4(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim c1,c2 as color
		  dim i,j as integer
		  dim return_pic As new ga_picture
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      c1 = furthest_neighbour(p1,i,j)
		      c2 = furthest_neighbour(p2,i,j)
		      if colour_diff(p1.picture(i,j),c1) > colour_diff(p2.picture(i,j),c2) then
		        return_pic.picture(i,j) = c1
		      else
		        return_pic.picture(i,j) = c2
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function evolve5(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim c1,c2,f1,f2 as color
		  dim i,j as integer
		  dim return_pic As new ga_picture
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      c1 = closest_neighbour(p1,i,j)
		      c2 = closest_neighbour(p2,i,j)
		      f1 = furthest_neighbour(p1,i,j)
		      f2 = furthest_neighbour(p2,i,j)
		      if colour_diff(c1,f1) > colour_diff(c2,f2) then
		        return_pic.picture(i,j) = c2
		      else
		        return_pic.picture(i,j) = c1
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolveEnabled()
		  if dumpIndex > - 1 and keepIndex > -1 and dumpIndex <> keepIndex then
		    EvolveButton.Enabled = true
		  else
		    EvolveButton.Enabled = false
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function furthest_neighbour(pic as ga_picture, x as integer, y as integer) As color
		  dim diff,max_diff as integer
		  dim return_colour as color
		  
		  max_diff = -1
		  
		  if x-1 > -1 and y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y-1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x-1,y-1)
		    end
		  end
		  if x-1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x-1,y)
		    end
		  end
		  if x-1 > -1 and y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 128 and y +1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 128 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 128 and y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y-1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x+1,y-1)
		    end
		  end
		  if y -1 > -1 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y-1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x,y-1)
		    end
		  end
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function neighbours_diff(pic as ga_picture, x as integer, y as integer) As integer
		  dim return_value as integer
		  
		  return_value = 0
		  
		  if x-1 > -1 and y -1 > -1 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x-1,y-1))
		  end
		  if x-1 > -1 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x-1,y))
		  end
		  if x-1 > -1 and y +1 < 128 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		  end
		  if y +1 < 128 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		  end
		  if x+1 < 128 and y +1 < 128 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		  end
		  if x+1 < 128 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		  end
		  if x+1 < 128 and y -1 > -1 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x+1,y-1))
		  end
		  if y -1 > -1 then
		    return_value = return_value + colour_diff(pic.picture(x,y),pic.picture(x,y-1))
		  end
		  
		  return return_value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function normalise(pic as ga_picture) As ga_picture
		  dim return_pic as new ga_picture
		  dim i,j,min_r,max_r,min_g,max_g,min_b,max_b as integer
		  dim r_ratio, g_ratio, b_ratio as double
		  
		  min_r = 255
		  min_g = 255
		  min_b = 255
		  max_r = 0 
		  max_g = 0
		  max_b = 0
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      if pic.picture(i,j).red < min_r then
		        min_r = pic.picture(i,j).red
		      end
		      if pic.picture(i,j).red > max_r then
		        max_r = pic.picture(i,j).red
		      end
		      if pic.picture(i,j).green < min_g then
		        min_g = pic.picture(i,j).green
		      end
		      if pic.picture(i,j).green > max_g then
		        max_g = pic.picture(i,j).green
		      end
		      if pic.picture(i,j).red < min_b then
		        min_b = pic.picture(i,j).red
		      end
		      if pic.picture(i,j).blue > max_b then
		        max_b = pic.picture(i,j).blue
		      end
		    next
		  next
		  
		  r_ratio = (max_r-min_r)/255
		  g_ratio = (max_g-min_g)/255 
		  b_ratio = (max_b-min_b)/255
		  
		  for i = 0 to 127
		    for j = 0 to 127
		      return_pic.picture(i,j) = rgb((pic.picture(i,j).red-min_r)/r_ratio,(pic.picture(i,j).green-min_g)/g_ratio,(pic.picture(i,j).blue-min_b)/b_ratio)
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		dumpIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ga_pictures_array(-1) As ga_picture
	#tag EndProperty

	#tag Property, Flags = &h0
		keepIndex As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events KeepDump
	#tag Event
		Sub Action(index as Integer, itemIndex as integer)
		  if itemIndex = 0 then
		    if keepIndex > -1 and keepIndex <> index then
		      KeepDump(keepIndex).Items(itemIndex).selected = false
		    end
		    keepIndex = index
		  else
		    if dumpIndex > -1 and dumpIndex <> index then
		      KeepDump(dumpIndex).Items(itemIndex).selected = false
		    end
		    dumpIndex = index
		  end
		  
		  evolveEnabled
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EvolveButton
	#tag Event
		Sub Action()
		  dim i,evolve_a,evolve_b,evolve_method as integer
		  dim temp_ga_p_array(-1) As ga_picture
		  
		  evolve_method = 5
		  evolve_a = -1
		  for i = 0 to 3
		    if i <> keepIndex and i <> dumpIndex then
		      if evolve_a = -1 then
		        evolve_a = i
		      else
		        evolve_b = i
		      end
		    end
		  next
		  
		  temp_ga_p_array.Append normalise(evolve(evolve_method,ga_pictures_array(keepIndex),ga_pictures_array(keepindex)))
		  temp_ga_p_array.Append normalise(evolve(evolve_method,ga_pictures_array(keepIndex),ga_pictures_array(evolve_a)))
		  temp_ga_p_array.Append normalise(evolve(evolve_method,ga_pictures_array(keepIndex),ga_pictures_array(evolve_b)))
		  temp_ga_p_array.Append normalise(evolve(evolve_method,ga_pictures_array(keepIndex),ga_pictures_array(dumpIndex)))
		  
		  redim ga_pictures_array(-1)
		  
		  for i = 0 to UBound(temp_ga_p_array)
		    ga_pictures_array.Append temp_ga_p_array(i)
		  next
		  
		  EvolveButton.Enabled = false
		  KeepDump(keepIndex).Items(0).selected = false
		  KeepDump(dumpIndex).Items(1).selected = false
		  keepindex = -1
		  dumpindex = -1
		  refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents
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
	#tag ViewProperty
		Name="dumpIndex"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="keepIndex"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
