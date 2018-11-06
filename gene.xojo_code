#tag Class
Protected Class gene
	#tag Method, Flags = &h0
		Function clone() As gene
		  dim g As new gene
		  
		  g.centre(0) = centre(0)
		  g.centre(1) = centre(1)
		  g.colour = colour
		  g.width = width
		  g.height = height
		  g.square_or_circle = square_or_circle
		  
		  return g
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolve()
		  dim mutate_factor as double
		  
		  mutate_factor = 0.01
		  
		  if rnd < mutate_factor then
		    centre(0) = centre(0)+rnd*32-16
		  end
		  if rnd < mutate_factor then
		    centre(1) = centre(1)+rnd*32-16
		  end
		  if rnd < mutate_factor then
		    colour = rgb(rnd*255,colour.Green,colour.blue)
		  end
		  if rnd < mutate_factor then
		    colour = rgb(colour.red,rnd*255,colour.blue)
		  end
		  if rnd < mutate_factor then
		    colour = rgb(colour.red,colour.Green,rnd*255)
		  end
		  if rnd < mutate_factor then
		    width = width * (rnd+0.5)
		  end
		  if rnd < mutate_factor then
		    height = height * (rnd+0.5)
		  end
		  if rnd < mutate_factor then
		    square_or_circle = not square_or_circle
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub init()
		  
		  centre(0) = rnd*parent.width/2+(parent.centre(0)-parent.width/4)
		  centre(1) = rnd*parent.height/2+(parent.centre(1)-parent.height/4)
		  colour = RGB(rnd*255,rnd*255,rnd*255)
		  width = rnd*(parent.width/2)+parent.width/2
		  height = rnd*(parent.height/2)+parent.height/2
		  if rnd < (2/3) then
		    square_or_circle = true
		  else
		    square_or_circle = false
		  end
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  if width > 127 then
		    width = 127
		  end
		  if height > 127 then
		    height = 127
		  end
		  if centre(0) - width / 2 > 63 then
		    centre(0) = width/2 + 63
		  end
		  if centre(0) + width / 2 < 0 then
		    centre(0) = 0 - width/2
		  end
		  if centre(1) - height / 2 > 63 then
		    centre(1) = height/2 + 63
		  end
		  if centre(1) + height / 2 < 0 then
		    centre(1) = 0 - height/2
		  end
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		centre(1) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		colour As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		height As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		parent As chromosome
	#tag EndProperty

	#tag Property, Flags = &h0
		square_or_circle As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		width As Integer
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
			Name="height"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="square_or_circle"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="colour"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="width"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
