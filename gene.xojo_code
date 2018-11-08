#tag Class
Protected Class gene
	#tag Method, Flags = &h0
		Function clone() As gene
		  dim g As new gene
		  
		  g.gcentre(0) = gcentre(0)
		  g.gcentre(1) = gcentre(1)
		  g.colour = colour
		  g.gwidth = gwidth
		  g.gheight = gheight
		  g.square_or_circle = square_or_circle
		  g.parent = parent
		  
		  return g
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolve()
		  dim mutate_factor as double
		  
		  mutate_factor = 0.01
		  
		  if rnd < mutate_factor then
		    gcentre(0) = gcentre(0)+rnd*32-16
		  end
		  if rnd < mutate_factor then
		    gcentre(1) = gcentre(1)+rnd*32-16
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
		    gwidth = gwidth * (rnd+0.5)
		  end
		  if rnd < mutate_factor then
		    gheight = gheight * (rnd+0.5)
		  end
		  if rnd < mutate_factor then
		    square_or_circle = not square_or_circle
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub init()
		  
		  gcentre(0) = rnd*parent.cwidth/2+(parent.ccentre(0)-parent.cwidth/4)
		  gcentre(1) = rnd*parent.cheight/2+(parent.ccentre(1)-parent.cheight/4)
		  colour = RGB(rnd*255,rnd*255,rnd*255)
		  gwidth = rnd*(parent.cwidth/2)+parent.cwidth/2
		  gheight = rnd*(parent.cheight/2)+parent.cheight/2
		  if rnd < (2/3) then
		    square_or_circle = true
		  else
		    square_or_circle = false
		  end
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  if gwidth > parent.cwidth*2-1 then
		    gwidth = parent.cwidth*2-1
		  end
		  if gheight > parent.cheight*2-1 then
		    gheight = parent.cheight*2-1
		  end
		  if gcentre(0) - gwidth / 2 > parent.cwidth-1 then
		    gcentre(0) = gwidth/2 + parent.cwidth-1
		  end
		  if gcentre(0) + gwidth / 2 < 0 then
		    gcentre(0) = 0 - gwidth/2
		  end
		  if gcentre(1) - gheight / 2 > parent.cheight-1 then
		    gcentre(1) = gheight/2 + parent.cheight-1
		  end
		  if gcentre(1) + gheight / 2 < 0 then
		    gcentre(1) = 0 - gheight/2
		  end
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		colour As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		gcentre(1) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		gheight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		gwidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		parent As chromosome
	#tag EndProperty

	#tag Property, Flags = &h0
		square_or_circle As boolean
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
			Name="gheight"
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
			Name="gwidth"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
