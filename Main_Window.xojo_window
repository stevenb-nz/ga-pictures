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
		  dim keep_d as ga_drawing
		  dim keep_p as ga_picture
		  dim temp_ga_d_array(-1) as ga_drawing
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
		    if drawing_mode then
		      c.Picture = ga_drawings_array(k).pic
		      
		      keep_d = ga_drawings_array(k)
		      ga_drawings_array.Remove(k)
		      
		      temp_ga_d_array.Append keep_d
		      
		      for i = 0 to UBound(ga_drawings_array)
		        temp_ga_d_array.Append breed_d(keep_d,ga_drawings_array(i))
		        temp_ga_d_array(UBound(temp_ga_d_array)).evolve
		        temp_ga_d_array(UBound(temp_ga_d_array)).normalise
		      next
		      
		      redim ga_drawings_array(-1)
		      
		      for i = 0 to UBound(temp_ga_d_array)
		        temp_ga_d_array(i).sort_genes
		        ga_drawings_array.Append temp_ga_d_array(i)
		      next
		    else
		      c.Picture = ga_pictures_array(k).pic
		      
		      keep_p = ga_pictures_array(k)
		      ga_pictures_array.Remove(k)
		      
		      temp_ga_p_array.Append keep_p
		      
		      for i = 0 to UBound(ga_pictures_array)
		        temp_ga_p_array.Append breed_p(keep_p,ga_pictures_array(i))
		      next
		      
		      redim ga_pictures_array(-1)
		      
		      for i = 0 to UBound(temp_ga_p_array)
		        temp_ga_p_array(i).evolve
		        temp_ga_p_array(i).normalise
		        ga_pictures_array.Append temp_ga_p_array(i)
		      next
		    end
		    
		    refresh
		    
		  end
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  drawing_mode = true
		  
		  if drawing_mode then
		    reset_drawings
		  else
		    reset_pictures
		  end
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  dim k as integer
		  
		  for k = 0 to 15
		    if drawing_mode then
		      g.DrawPicture(ga_drawings_array(k).pic,74*(k mod 4)+20,74*(k \ 4)+20)
		    else
		      g.DrawPicture(ga_pictures_array(k).pic,74*(k mod 4)+20,74*(k \ 4)+20)
		    end
		  next
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileReset() As Boolean Handles FileReset.Action
			if drawing_mode then
			reset_drawings
			else
			reset_pictures
			end
			Refresh
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function breed_d(d1 as ga_drawing, d2 as ga_drawing) As ga_drawing
		  dim i,l1,l2 as integer
		  dim return_drawing As new ga_drawing
		  
		  l1 = UBound(d1.chromosomes)+1
		  l2 = UBound(d2.chromosomes)+1
		  
		  if l1 < l2 then
		    for i = 0 to (l2 mod l1) * (l2 \ l1+1) - 1
		      return_drawing.chromosomes.Append breed_dc(d1.chromosomes(i\((l2 \ l1)+1)),d2.chromosomes(i))
		    next
		    for i = (l2 mod l1) * (l2 \ l1+1) to UBound(d2.chromosomes)
		      return_drawing.chromosomes.Append breed_dc(d1.chromosomes((i-l2 mod l1)\(l2 \ l1)),d2.chromosomes(i))
		    next
		  ElseIf l1 > l2 then
		    for i = 0 to (l1 mod l2) * (l1 \ l2+1) - 1
		      return_drawing.chromosomes.Append breed_dc(d1.chromosomes(i),d2.chromosomes(i\((l1 \ l2)+1)))
		    next
		    for i = (l1 mod l2) * (l1 \ l2+1) to UBound(d1.chromosomes)
		      return_drawing.chromosomes.Append breed_dc(d1.chromosomes(i),d2.chromosomes((i-l1 mod l2)\(l1 \ l2)))
		    next
		  else
		    for i = 0 to UBound(d1.chromosomes)
		      return_drawing.chromosomes.Append breed_dc(d1.chromosomes(i),d2.chromosomes(i))
		    next
		  end
		  
		  return return_drawing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function breed_dc(c1 as chromosome, c2 as chromosome) As chromosome
		  dim i,l1,l2 as integer
		  dim return_chromosome As new chromosome
		  
		  Select case rnd*4
		  case 0
		    return_chromosome.ccentre(0) = c2.ccentre(0)
		    return_chromosome.ccentre(1) = c2.ccentre(1)
		    return_chromosome.cwidth = c2.cwidth
		    return_chromosome.cheight = c2.cheight
		  case 1
		    return_chromosome.ccentre(0) = (c1.ccentre(0)+c2.ccentre(0))\2
		    return_chromosome.ccentre(1) = (c1.ccentre(1)+c2.ccentre(1))\2
		    return_chromosome.cwidth = (c1.cwidth+c2.cwidth)\2
		    return_chromosome.cheight = (c1.cheight+c2.cheight)\2
		  else
		    return_chromosome.ccentre(0) = c1.ccentre(0)
		    return_chromosome.ccentre(1) = c1.ccentre(1)
		    return_chromosome.cwidth = c1.cwidth
		    return_chromosome.cheight = c1.cheight
		  end select
		  
		  l1 = UBound(c1.genes)+1
		  l2 = UBound(c2.genes)+1
		  
		  if l1 < l2 then
		    for i = 0 to (l2 mod l1) * (l2 \ l1+1) - 1
		      return_chromosome.genes.Append breed_dg(c1.genes(i\((l2 \ l1)+1)),c2.genes(i))
		      return_chromosome.genes(UBound(return_chromosome.genes)).parent = return_chromosome
		    next
		    for i = (l2 mod l1) * (l2 \ l1+1) to ubound(c2.genes)
		      return_chromosome.genes.Append breed_dg(c1.genes((i-l2 mod l1)\(l2 \ l1)),c2.genes(i))
		      return_chromosome.genes(UBound(return_chromosome.genes)).parent = return_chromosome
		    next
		  elseif l1 > l2 then
		    for i = 0 to (l1 mod l2) * (l1 \ l2+1) - 1
		      return_chromosome.genes.Append breed_dg(c1.genes(i),c2.genes(i\((l1 \ l2)+1)))
		      return_chromosome.genes(UBound(return_chromosome.genes)).parent = return_chromosome
		    next
		    for i = (l1 mod l2) * (l1 \ l2+1) to ubound(c1.genes)
		      return_chromosome.genes.Append breed_dg(c1.genes(i),c2.genes((i-l1 mod l2)\(l1 \ l2)))
		      return_chromosome.genes(UBound(return_chromosome.genes)).parent = return_chromosome
		    next
		  else
		    for i = 0 to ubound(c1.genes)
		      return_chromosome.genes.Append breed_dg(c1.genes(i),c2.genes(i))
		      return_chromosome.genes(UBound(return_chromosome.genes)).parent = return_chromosome
		    next
		  end
		  
		  return return_chromosome
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function breed_dg(g1 as gene, g2 as gene) As gene
		  dim return_gene As new gene
		  
		  Select case rnd*4
		  case 0
		    return_gene.gcentre(0) = g2.gcentre(0)
		    return_gene.gcentre(1) = g2.gcentre(1)
		    return_gene.colour = g2.colour
		    return_gene.gwidth = g2.gwidth
		    return_gene.gheight = g2.gheight
		    return_gene.square_or_circle = g2.square_or_circle
		  case 1
		    return_gene.gcentre(0) = (g1.gcentre(0)+g2.gcentre(0))\2
		    return_gene.gcentre(1) = (g1.gcentre(1)+g2.gcentre(1))\2
		    return_gene.colour = RGB((g1.colour.red+g2.colour.red)\2,(g1.colour.green+g2.colour.green)\2,(g1.colour.blue+g2.colour.blue)\2)
		    return_gene.gwidth = (g1.gwidth+g2.gwidth)\2
		    return_gene.gheight = (g1.gheight+g2.gheight)\2
		    return_gene.square_or_circle = not g2.square_or_circle
		  else
		    return_gene.gcentre(0) = g1.gcentre(0)
		    return_gene.gcentre(1) = g1.gcentre(1)
		    return_gene.colour = g1.colour
		    return_gene.gwidth = g1.gwidth
		    return_gene.gheight = g1.gheight
		    return_gene.square_or_circle = g1.square_or_circle
		  end select
		  
		  return return_gene
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function breed_p(p1 as ga_picture, p2 as ga_picture) As ga_picture
		  dim i,j as integer
		  dim dr as double
		  dim return_pic As new ga_picture
		  
		  dr = p1.dominant_ratio
		  return_pic.evolve_iterations = ceil(p1.evolve_iterations*dr + p2.evolve_iterations*(1-dr))
		  return_pic.dominant_ratio = p1.dominant_ratio*dr + p2.dominant_ratio*(1-dr)
		  return_pic.mutate_ratio = p1.mutate_ratio*dr + p2.mutate_ratio*(1-dr)
		  
		  for i = 0 to 63
		    for j = 0 to 63
		      if p1.picture(i,j) = p2.picture(i,j) and rnd < return_pic.mutate_ratio then
		        return_pic.picture(i,j) = rgb(255 - p1.picture(i,j).red, 255 - p1.picture(i,j).green, 255 - p1.picture(i,j).blue)
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
		Function closest_neighbour(pic as ga_picture, directions() as integer, x as integer, y as integer) As color
		  dim i, diff,min_diff as integer
		  dim return_colour as color
		  
		  min_diff = 256
		  
		  for i = 0 to 7
		    select case directions(i)
		    case 0
		      if x-1 > -1 and y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y-1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x-1,y-1)
		        end
		      end
		    case 1
		      if x-1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x-1,y)
		        end
		      end
		    case 2
		      if x-1 > -1 and y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x-1,y+1)
		        end
		      end
		    case 3
		      if y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x,y+1)
		        end
		      end
		    case 4
		      if x+1 < 64 and y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x+1,y+1)
		        end
		      end
		    case 5
		      if x+1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x+1,y)
		        end
		      end
		    case 6
		      if x+1 < 64 and y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y-1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x+1,y-1)
		        end
		      end
		    case 7
		      if y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x,y-1))
		        if diff < min_diff then
		          min_diff = diff
		          return_colour = pic.picture(x,y-1)
		        end
		      end    
		    End Select
		  next
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function colour_diff(c1 as Color, c2 as Color) As integer
		  return abs(c1.Red-c2.Red)+abs(c1.green-c2.green)+abs(c1.blue-c2.blue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function furthest_neighbour(pic as ga_picture, directions() as integer, x as integer, y as integer) As color
		  dim i, diff,max_diff as integer
		  dim return_colour as color
		  
		  max_diff = -1
		  
		  for i = 0 to 7
		    select case directions(i)
		    case 0
		      if x-1 > -1 and y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y-1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x-1,y-1)
		        end
		      end
		    case 1
		      if x-1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x-1,y)
		        end
		      end
		    case 2
		      if x-1 > -1 and y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x-1,y+1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x-1,y+1)
		        end
		      end
		    case 3
		      if y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x,y+1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x,y+1)
		        end
		      end
		    case 4
		      if x+1 < 64 and y +1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y+1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x+1,y+1)
		        end
		      end
		    case 5
		      if x+1 < 64 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x+1,y)
		        end
		      end
		    case 6
		      if x+1 < 64 and y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x+1,y-1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x+1,y-1)
		        end
		      end
		    case 7
		      if y -1 > -1 then
		        diff = colour_diff(pic.picture(x,y),pic.picture(x,y-1))
		        if diff > max_diff then
		          max_diff = diff
		          return_colour = pic.picture(x,y-1)
		        end
		      end    
		    End Select
		  next
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function merge_colours(c1 as Color, c2 as Color) As Color
		  return  rgb(ceil((c1.red + c2.red) / 2), ceil((c1.green + c2.green) / 2), ceil((c1.blue + c2.blue) / 2))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mp_neighbour(pic as ga_picture, directions() as integer, x as integer, y as integer) As color
		  dim i, mp, mp_temp as integer
		  dim temp_colour, return_colour as color
		  
		  mp = 256
		  for i = 0 to 7
		    select case directions(i)
		    case 0
		      if x-1 > -1 and y -1 > -1 then
		        temp_colour = pic.picture(x-1,y-1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 1
		      if x-1 > -1 then
		        temp_colour = pic.picture(x-1,y)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 2
		      if x-1 > -1 and y +1 < 64 then
		        temp_colour = pic.picture(x-1,y+1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 3
		      if y +1 < 64 then
		        temp_colour = pic.picture(x,y+1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 4
		      if x+1 < 64 and y +1 < 64 then
		        temp_colour = pic.picture(x+1,y+1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 5
		      if x+1 < 64 then
		        temp_colour = pic.picture(x+1,y)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 6
		      if x+1 < 64 and y -1 > -1 then
		        temp_colour = pic.picture(x+1,y-1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    case 7
		      if y -1 > -1 then
		        temp_colour = pic.picture(x,y-1)
		        mp_temp = temp_colour.red + temp_colour.Green + temp_colour.Blue
		        mp_temp = min(abs(255-mp_temp),abs(510-mp_temp)) + min(temp_colour.red,255-temp_colour.red) + min(temp_colour.green,255-temp_colour.green) + min(temp_colour.blue,255-temp_colour.blue)
		        if mp_temp < mp then
		          mp = mp_temp
		          return_colour = temp_colour
		        end
		      end
		    End Select
		  next
		  
		  return return_colour
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_drawings()
		  dim i,j,k as integer
		  dim new_ga_d as ga_drawing
		  dim new_c as chromosome
		  dim new_g as gene
		  redim ga_drawings_array(-1)
		  
		  for k = 0 to 15
		    new_ga_d = new ga_drawing
		    for i = 0 to rnd*3+3
		      new_c = new chromosome
		      new_c.init
		      for j = 0 to rnd*3+3
		        new_g = new gene
		        new_g.parent = new_c
		        new_g.init
		        new_c.genes.Append new_g
		      next
		      new_ga_d.chromosomes.Append new_c
		    next
		    new_ga_d.sort_genes
		    ga_drawings_array.Append new_ga_d
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_pictures()
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
		    
		    new_ga_p.evolve
		    new_ga_p.normalise
		    
		    ga_pictures_array.Append new_ga_p
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		drawing_mode As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ga_drawings_array(-1) As ga_drawing
	#tag EndProperty

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
	#tag ViewProperty
		Name="drawing_mode"
		Group="Behavior"
		Type="boolean"
	#tag EndViewProperty
#tag EndViewBehavior
