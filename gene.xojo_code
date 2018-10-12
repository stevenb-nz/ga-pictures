#tag Class
Protected Class gene
	#tag Method, Flags = &h0
		Sub init()
		  centre(0) = rnd*64
		  centre(1) = rnd*64
		  colour = RGB(rnd*255,rnd*255,rnd*255)
		  span = rnd*64
		  if rnd < 0.5 then
		    square_or_circle = true
		  else
		    square_or_circle = false
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
		span As Integer
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
			Name="span"
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
	#tag EndViewBehavior
End Class
#tag EndClass
