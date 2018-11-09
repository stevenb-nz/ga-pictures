#tag Class
Protected Class chromosome
	#tag Method, Flags = &h0
		Function clone() As chromosome
		  dim c As new chromosome
		  dim i As Integer
		  
		  c.cheight = cheight
		  c.cwidth = cwidth
		  c.ccentre(0) = ccentre(0)
		  c.ccentre(1) = ccentre(1)
		  
		  for i = 0 to UBound(genes)
		    c.genes.Append genes(i).clone
		  next
		  
		  return c
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub evolve()
		  dim i as integer
		  dim mutate_factor as double
		  
		  mutate_factor = 0.01
		  
		  if rnd < mutate_factor then
		    ccentre(0) = ccentre(0)+rnd*32-16
		  end
		  if rnd < mutate_factor then
		    ccentre(1) = ccentre(1)+rnd*32-16
		  end
		  if rnd < mutate_factor then
		    cwidth = cwidth * (rnd+0.5)
		  end
		  if rnd < mutate_factor then
		    cheight = cheight * (rnd+0.5)
		  end
		  
		  if rnd < 0.1 then
		    i = rnd*(UBound(genes)+1)
		    genes.Insert(i,genes(i).clone)
		  end
		  
		  if rnd < 0.15 then
		    i = rnd*(UBound(genes)+1)
		    genes.Remove(i)
		  end
		  
		  for i = 0 to UBound(genes)
		    genes(i).evolve
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function geneCompare(g1 As gene, g2 As gene) As Integer
		  If g1.gwidth*g1.gheight > g2.gwidth*g2.gheight Then Return 1
		  If g1.gwidth*g1.gheight < g2.gwidth*g2.gheight Then Return -1
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub init()
		  ccentre(0) = rnd*32+16
		  ccentre(1) = rnd*32+16
		  cwidth = rnd*32+32
		  cheight = rnd*32+32
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub normalise()
		  dim i as Integer
		  
		  while UBound(genes) > 10
		    genes.remove(0)
		  wend
		  
		  for i = 0 to UBound(genes)
		    genes(i).normalise
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sort_genes()
		  genes.Sort(AddressOf geneCompare)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ccentre(1) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		cheight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		cwidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		genes(-1) As gene
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
			Name="cheight"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cwidth"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
