#tag Class
Protected Class ga_drawing
	#tag Method, Flags = &h0
		Function chromosomeCompare(c1 as chromosome, c2 as chromosome) As integer
		  If c1.cwidth*c1.cheight < c2.cwidth*c2.cheight Then Return 1
		  If c1.cwidth*c1.cheight > c2.cwidth*c2.cheight Then Return -1
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolve()
		  dim i as integer
		  
		  if rnd < 0.1 then
		    i = rnd*(UBound(chromosomes)+1)
		    chromosomes.Insert(i,chromosomes(i).clone)
		  end
		  
		  if rnd < 0.15 then
		    i = rnd*(UBound(chromosomes)+1)
		    chromosomes.Remove(i)
		  end
		  
		  for i = 0 to UBound(chromosomes)
		    chromosomes(i).evolve
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  dim i as Integer
		  
		  while UBound(chromosomes) > 40
		    chromosomes.remove(0)
		  wend
		  
		  for i = 0 to UBound(chromosomes)
		    chromosomes(i).normalise
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pic() As Picture
		  dim i,j,span,width,height as Integer
		  dim p as new picture(64,64,32)
		  
		  for i = 0 to UBound(chromosomes)
		    for j = 0 to ubound(chromosomes(i).genes)
		      p.Graphics.ForeColor = chromosomes(i).genes(j).colour
		      if chromosomes(i).genes(j).square_or_circle then
		        width = chromosomes(i).genes(j).gwidth
		        height = chromosomes(i).genes(j).gheight
		        p.Graphics.FillRect(chromosomes(i).genes(j).gcentre(0)-width\2,chromosomes(i).genes(j).gcentre(1)-height\2,width,height)
		      else
		        span = (chromosomes(i).genes(j).gwidth+chromosomes(i).genes(j).gheight)/2
		        p.Graphics.FillOval(chromosomes(i).genes(j).gcentre(0)-span\2,chromosomes(i).genes(j).gcentre(1)-span\2,span,span)
		      end
		    next
		  next
		  
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sort_genes()
		  dim i as Integer
		  
		  for i = 0 to UBound(chromosomes)
		    chromosomes(i).sort_genes
		  next
		  
		  chromosomes.Sort(AddressOf chromosomeCompare)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		chromosomes(-1) As chromosome
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
