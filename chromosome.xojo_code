#tag Class
Protected Class chromosome
	#tag Method, Flags = &h0
		Function clone() As chromosome
		  dim c As new chromosome
		  dim i As Integer
		  
		  for i = 0 to UBound(chromosome)
		    c.chromosome.Append chromosome(i).clone
		  next
		  
		  return c
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolve()
		  dim i as integer
		  
		  if rnd < 0.1 then
		    i = rnd*(UBound(chromosome)+1)
		    chromosome.Insert(i,chromosome(i).clone)
		  end
		  
		  if rnd < 0.15 then
		    i = rnd*(UBound(chromosome)+1)
		    chromosome.Remove(i)
		  end
		  
		  for i = 0 to UBound(chromosome)
		    chromosome(i).evolve
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		chromosome(-1) As gene
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
	#tag EndViewBehavior
End Class
#tag EndClass
