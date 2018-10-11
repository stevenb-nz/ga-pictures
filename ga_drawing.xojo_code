#tag Class
Protected Class ga_drawing
	#tag Property, Flags = &h0
		dominant_ratio As double
	#tag EndProperty

	#tag Property, Flags = &h0
		genome(-1) As chromosome
	#tag EndProperty

	#tag Property, Flags = &h0
		mutate_ratio As double
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
	#tag EndViewBehavior
End Class
#tag EndClass
