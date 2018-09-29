#tag Class
Protected Class ga_picture
	#tag Method, Flags = &h0
		Function clone() As ga_picture
		  dim copy as new ga_picture
		  dim i,j as integer
		  
		  copy.evolve_iterations = evolve_iterations
		  
		  for i = 0 to 63
		    for j = 0 to 63
		      copy.picture(i,j) = picture(i,j)
		    next
		  next
		  
		  return copy
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		evolve_iterations As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
