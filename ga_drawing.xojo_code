#tag Class
Protected Class ga_drawing
	#tag Method, Flags = &h0
		Function chromosomeCompare(c1 as chromosome, c2 as chromosome) As integer
		  If c1.chromosome(0).width*c1.chromosome(0).height < c2.chromosome(0).width*c2.chromosome(0).height Then Return 1
		  If c1.chromosome(0).width*c1.chromosome(0).height > c2.chromosome(0).width*c2.chromosome(0).height Then Return -1
		  Return 0
		  
		End Function
	#tag EndMethod

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
		Sub normalise()
		  dim i as Integer
		  
		  for i = 0 to UBound(genome)
		    genome(i).normalise
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pic() As Picture
		  dim i,j,span,width,height as Integer
		  dim p as new picture(64,64,32)
		  
		  for i = 0 to UBound(genome)
		    for j = 0 to ubound(genome(i).chromosome)
		      p.Graphics.ForeColor = genome(i).chromosome(j).colour
		      if genome(i).chromosome(j).square_or_circle then
		        width = genome(i).chromosome(j).width
		        height = genome(i).chromosome(j).height
		        p.Graphics.FillRect(genome(i).chromosome(j).centre(0)-width\2,genome(i).chromosome(j).centre(1)-height\2,width,height)
		      else
		        span = min(genome(i).chromosome(j).width,genome(i).chromosome(j).height)
		        p.Graphics.FillOval(genome(i).chromosome(j).centre(0)-span\2,genome(i).chromosome(j).centre(1)-span\2,span,span)
		      end
		    next
		  next
		  
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sort_genes()
		  dim i as Integer
		  
		  for i = 0 to UBound(genome)
		    genome(i).sort_genes
		  next
		  
		  genome.Sort(AddressOf chromosomeCompare)
		  
		End Sub
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
