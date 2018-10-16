#tag Class
Protected Class ga_drawing
	#tag Method, Flags = &h0
		Sub evolve()
		  dim i as integer
		  
		  if rnd < 0.1 then
		    i = rnd*(UBound(genome)+1)
		    genome.Insert(i,genome(i).clone)
		  end
		  
		  if rnd < 0.15 then
		    i = rnd*(UBound(genome)+1)
		    genome.Remove(i)
		  end
		  
		  for i = 0 to UBound(genome)
		    genome(i).evolve
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pic() As Picture
		  dim i,j as Integer
		  dim p as new picture(64,64,32)
		  
		  for i = 0 to UBound(genome)
		    for j = 0 to ubound(genome(i).chromosome)
		      p.Graphics.ForeColor = genome(i).chromosome(j).colour
		      if genome(i).chromosome(j).square_or_circle then
		        p.Graphics.FillRect(genome(i).chromosome(j).centre(0)-genome(i).chromosome(j).span\2,genome(i).chromosome(j).centre(1)-genome(i).chromosome(j).span\2,genome(i).chromosome(j).span,genome(i).chromosome(j).span)
		      else
		        p.Graphics.FillOval(genome(i).chromosome(j).centre(0)-genome(i).chromosome(j).span\2,genome(i).chromosome(j).centre(1)-genome(i).chromosome(j).span\2,genome(i).chromosome(j).span,genome(i).chromosome(j).span)
		      end
		    next
		  next
		  
		  return p
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		genome(-1) As chromosome
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
