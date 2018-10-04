#tag Class
Protected Class ga_picture
	#tag Method, Flags = &h0
		Sub evolve()
		  dim c,f as color
		  dim i,j,k as integer
		  dim temp_pic As new ga_picture
		  
		  for k = 1 to evolve_iterations
		    for i = 0 to 63
		      for j = 0 to 63
		        c = Main_Window.closest_neighbour(me,i,j)
		        f = Main_Window.furthest_neighbour(me,i,j)
		        if Main_Window.colour_diff(f,picture(i,j)) = 0 then
		          temp_pic.picture(i,j) = rgb(rnd*256,rnd*256,rnd*256)
		        else
		          temp_pic.picture(i,j) = c
		        end
		      next
		    next
		    for i = 0 to 63
		      for j = 0 to 63
		        picture(i,j) = temp_pic.picture(i,j)
		      next
		    next
		  next
		  for k = 1 to evolve_iterations
		    for i = 0 to 63
		      for j = 0 to 63
		        temp_pic.picture(i,j) = Main_Window.mp_neighbour(me,i,j)
		      next
		    next
		    for i = 0 to 63
		      for j = 0 to 63
		        picture(i,j) = temp_pic.picture(i,j)
		      next
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  dim i,j,min_r,max_r,min_g,max_g,min_b,max_b as integer
		  dim r_ratio, g_ratio, b_ratio as double
		  
		  min_r = 255
		  min_g = 255
		  min_b = 255
		  max_r = 0 
		  max_g = 0
		  max_b = 0
		  
		  for i = 0 to 63
		    for j = 0 to 63
		      if picture(i,j).red < min_r then
		        min_r = picture(i,j).red
		      end
		      if picture(i,j).red > max_r then
		        max_r = picture(i,j).red
		      end
		      if picture(i,j).green < min_g then
		        min_g = picture(i,j).green
		      end
		      if picture(i,j).green > max_g then
		        max_g = picture(i,j).green
		      end
		      if picture(i,j).red < min_b then
		        min_b = picture(i,j).red
		      end
		      if picture(i,j).blue > max_b then
		        max_b = picture(i,j).blue
		      end
		    next
		  next
		  
		  r_ratio = (max_r-min_r)/255
		  g_ratio = (max_g-min_g)/255 
		  b_ratio = (max_b-min_b)/255
		  
		  if r_ratio + g_ratio + b_ratio < 3 then
		    for i = 0 to 63
		      for j = 0 to 63
		        picture(i,j) = rgb((picture(i,j).red-min_r)/r_ratio,(picture(i,j).green-min_g)/g_ratio,(picture(i,j).blue-min_b)/b_ratio)
		      next
		    next
		  end
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pic() As Picture
		  dim i,j as Integer
		  dim p as new picture(64,64,32)
		  
		  for i = 0 to 63
		    for j = 0 to 63
		      p.RGBSurface.Pixel(i,j) = picture(i,j)
		    next
		  next
		  
		  return p
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		dominant_ratio As double
	#tag EndProperty

	#tag Property, Flags = &h0
		evolve_iterations As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		mutate_ratio As double
	#tag EndProperty

	#tag Property, Flags = &h0
		picture(64,64) As Color
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="evolve_iterations"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dominant_ratio"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mutate_ratio"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dorb"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
