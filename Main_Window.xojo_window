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
   Height          =   326
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   326
   MaximizeButton  =   True
   MaxWidth        =   326
   MenuBar         =   671768575
   MenuBarVisible  =   True
   MinHeight       =   326
   MinimizeButton  =   True
   MinWidth        =   326
   Placement       =   0
   Resizeable      =   False
   Title           =   "GA Pictures"
   Visible         =   True
   Width           =   326
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  dim i,k as integer
		  dim xminus20, yminus20, xdiv74, ydiv74, xmod74, ymod74 as integer
		  dim keep as ga_picture
		  dim temp_ga_p_array(-1) as ga_picture
		  dim c as new Clipboard
		  
		  xminus20 = x - 20
		  yminus20 = y - 20
		  xdiv74 = xminus20 \ 74
		  xmod74 = xminus20 mod 74
		  ydiv74 = yminus20 \ 74
		  ymod74= yminus20 mod 74
		  if xmod74 > 0 and xmod74 < 65 and ymod74 > 0 and ymod74 < 65 then
		    k = xdiv74 + ydiv74*4
		    
		    c.Picture = ga_pictures_array(k).pic
		    
		    keep = ga_pictures_array(k)
		    ga_pictures_array.Remove(k)
		    
		    temp_ga_p_array.Append keep
		    
		    for i = 0 to UBound(ga_pictures_array)
		      temp_ga_p_array.Append breed(keep,ga_pictures_array(i))
		    next
		    
		    redim ga_pictures_array(-1)
		    
		    for i = 0 to UBound(temp_ga_p_array)
		      temp_ga_p_array(i).evolve
		      temp_ga_p_array(i).normalise
		      ga_pictures_array.Append temp_ga_p_array(i)
		    next
		    
		    refresh
		    
		  end
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  reset
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  dim i,j,k as integer
		  
		  for k = 0 to 15
		    g.DrawPicture(ga_pictures_array(k).pic,74*(k mod 4)+20,74*(k \ 4)+20)
		  next
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileReset() As Boolean Handles FileReset.Action
			reset
			Refresh
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function breed(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim i,j as integer
		  dim dr as double
		  dim return_pic As new ga_picture
		  
		  dr = p1.dominant_ratio
		  return_pic.evolve_iterations = ceil(p1.evolve_iterations*dr + p2.evolve_iterations*(1-dr))
		  return_pic.dominant_ratio = p1.dominant_ratio*dr + p2.dominant_ratio*(1-dr)
		  return_pic.mutate_ratio = p1.mutate_ratio*dr + p2.mutate_ratio*(1-dr)
		  if p1.dorb xor p2.dorb then
		    return_pic.dorb = p1.dorb
		  else
		    return_pic.dorb = not p1.dorb
		  end
		  
		  for i = 0 to 63
		    for j = 0 to 63
		      if p1.picture(i,j) = p2.picture(i,j) and rnd < return_pic.mutate_ratio then
		        return_pic.picture(i,j) = rgb(rnd*256,rnd*256,rnd*256)
		      else
		        if rnd < return_pic.dominant_ratio then
		          return_pic.picture(i,j) = p1.picture(i,j)
		        else
		          return_pic.picture(i,j) = p2.picture(i,j)
		        end
		      end
		    next
		  next
		  
		  return return_pic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function brightest_neighbour(pic as ga_picture, x as integer, y as integer) As color
		  dim brightest, how_bright as integer
		  dim return_colour as color
		  
		  brightest = -1
		  
		  if x-1 > -1 and y -1 > -1 then
		    how_bright = pic.picture(x-1,y-1).red + pic.picture(x-1,y-1).green + pic.picture(x-1,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y-1)
		    end
		  end
		  if x-1 > -1 then
		    how_bright = pic.picture(x-1,y).red + pic.picture(x-1,y).green + pic.picture(x-1,y).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y)
		    end
		  end
		  if x-1 > -1 and y +1 < 64 then
		    how_bright = pic.picture(x-1,y+1).red + pic.picture(x-1,y+1).green + pic.picture(x-1,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 64 then
		    how_bright = pic.picture(x,y+1).red + pic.picture(x,y+1).green + pic.picture(x,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 64 and y +1 < 64 then
		    how_bright = pic.picture(x+1,y+1).red + pic.picture(x+1,y+1).green + pic.picture(x+1,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 64 then
		    how_bright = pic.picture(x+1,y).red + pic.picture(x+1,y).green + pic.picture(x+1,y).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 64 and y -1 > -1 then
		    how_bright = pic.picture(x+1,y-1).red + pic.picture(x+1,y-1).green + pic.picture(x+1,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y-1)
		    end
		  end
		  if y -1 > -1 then
		    how_bright = pic.picture(x,y-1).red + pic.picture(x,y-1).green + pic.picture(x,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x,y-1)
		    end
		  end
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

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
		  if x-1 > -1 and y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 64 and y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		    if diff < min_diff then
		      min_diff = diff
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 64 and y -1 > -1 then
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
		Function darkest_neighbour(pic as ga_picture, x as integer, y as integer) As color
		  dim darkest, how_dark as integer
		  dim return_colour as color
		  
		  darkest = 765
		  
		  if x-1 > -1 and y -1 > -1 then
		    how_dark = pic.picture(x-1,y-1).red + pic.picture(x-1,y-1).green + pic.picture(x-1,y-1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x-1,y-1)
		    end
		  end
		  if x-1 > -1 then
		    how_dark = pic.picture(x-1,y).red + pic.picture(x-1,y).green + pic.picture(x-1,y).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x-1,y)
		    end
		  end
		  if x-1 > -1 and y +1 < 64 then
		    how_dark = pic.picture(x-1,y+1).red + pic.picture(x-1,y+1).green + pic.picture(x-1,y+1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 64 then
		    how_dark = pic.picture(x,y+1).red + pic.picture(x,y+1).green + pic.picture(x,y+1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 64 and y +1 < 64 then
		    how_dark = pic.picture(x+1,y+1).red + pic.picture(x+1,y+1).green + pic.picture(x+1,y+1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 64 then
		    how_dark = pic.picture(x+1,y).red + pic.picture(x+1,y).green + pic.picture(x+1,y).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 64 and y -1 > -1 then
		    how_dark = pic.picture(x+1,y-1).red + pic.picture(x+1,y-1).green + pic.picture(x+1,y-1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x+1,y-1)
		    end
		  end
		  if y -1 > -1 then
		    how_dark = pic.picture(x,y-1).red + pic.picture(x,y-1).green + pic.picture(x,y-1).blue
		    if darkest > how_dark then
		      darkest = how_dark
		      return_colour = pic.picture(x,y-1)
		    end
		  end
		  
		  return return_colour
		  
		End Function
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
		  if x-1 > -1 and y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 64 and y +1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 64 then
		    diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		    if diff > max_diff then
		      max_diff = diff
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 64 and y -1 > -1 then
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
		Function mp_neighbour(pic as ga_picture, x as integer, y as integer) As color
		  dim mp, mp_temp as integer
		  dim return_colour as color
		  
		  mp = 128
		  
		  if x-1 > -1 and y -1 > -1 then
		    how_bright = pic.picture(x-1,y-1).red + pic.picture(x-1,y-1).green + pic.picture(x-1,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y-1)
		    end
		  end
		  if x-1 > -1 then
		    how_bright = pic.picture(x-1,y).red + pic.picture(x-1,y).green + pic.picture(x-1,y).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y)
		    end
		  end
		  if x-1 > -1 and y +1 < 64 then
		    how_bright = pic.picture(x-1,y+1).red + pic.picture(x-1,y+1).green + pic.picture(x-1,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x-1,y+1)
		    end
		  end
		  if y +1 < 64 then
		    how_bright = pic.picture(x,y+1).red + pic.picture(x,y+1).green + pic.picture(x,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x,y+1)
		    end
		  end
		  if x+1 < 64 and y +1 < 64 then
		    how_bright = pic.picture(x+1,y+1).red + pic.picture(x+1,y+1).green + pic.picture(x+1,y+1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y+1)
		    end
		  end
		  if x+1 < 64 then
		    how_bright = pic.picture(x+1,y).red + pic.picture(x+1,y).green + pic.picture(x+1,y).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y)
		    end
		  end
		  if x+1 < 64 and y -1 > -1 then
		    how_bright = pic.picture(x+1,y-1).red + pic.picture(x+1,y-1).green + pic.picture(x+1,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x+1,y-1)
		    end
		  end
		  if y -1 > -1 then
		    how_bright = pic.picture(x,y-1).red + pic.picture(x,y-1).green + pic.picture(x,y-1).blue
		    if brightest < how_bright then
		      brightest = how_bright
		      return_colour = pic.picture(x,y-1)
		    end
		  end
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  dim i,j,k as integer
		  dim new_ga_p as ga_picture
		  redim ga_pictures_array(-1)
		  
		  for k = 0 to 15
		    new_ga_p = new ga_picture
		    
		    for i = 0 to 63
		      for j = 0 to 63
		        new_ga_p.picture(i,j) = rgb(rnd*256,rnd*256,rnd*256)
		      next
		    next
		    
		    new_ga_p.evolve_iterations = ceil(rnd*4)
		    new_ga_p.dominant_ratio = rnd/2 + 0.5
		    new_ga_p.mutate_ratio = rnd
		    if rnd < 0.5 then
		      new_ga_p.dorb = false
		    else
		      new_ga_p.dorb = true
		    end
		    
		    new_ga_p.evolve
		    new_ga_p.normalise
		    
		    ga_pictures_array.Append new_ga_p
		  next
		  
		End Sub
	#tag EndMethod


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
