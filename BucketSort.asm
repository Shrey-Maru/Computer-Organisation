.data
arr: .float 0.897,0.78, 0.42324, 0.656, 0.1234 # Input array
n: .word 5                                                # Number of elements in input array
bucket: .float 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0          # Number of buckets to use
string: 
	.asciiz "AAA"





.text
main:
      # Load input array address into $s0
	la $s0, arr
	la $s3, bucket
	lw $t0, n
	move $s1,$zero
loop1:
	beq $s1, $t0, exitloop1
	sll $t1, $s1, 2   		#t1 = 4i
	add $t1, $t1, $s0			#t1 = t1 + arr
	l.s $f0,0($t1)
	li.s $f1,10.0
	mul.s $f2, $f0, $f1
	cvt.w.s $f3, $f2 			# we use $f3 as a temp here
	mfc1 $t2, $f3
	
	
	move $s2,$zero		#j = s2
	
inner1:
	li $t3,3
	mul $t2,$t2,$t3
	add $t2,$t2,$s2
	sll $s4,$t2,2
	add $s4,$s4,$s3
	l.s $f5,0($s4)			#f5=bucket bucket_index  j 
	li.s $f4,0.0
	#beq $zero,$f5,exitinner1
	c.eq.s $f5,$f4
	bc1t exitinner1
	addi $s2,$s2,1			#j = j+1
	j inner1
exitinner1:
	swc1 $f0,0($s4)
	addi $s1,$s1,1			#i = i+1
	j loop1
exitloop1:
	
	li $t0,10
	move $s5,$zero	#k=0
	
insertion_sort:
	beq $s5,$t0,exitsort
	li $s1,1		#i=1
	#move $s2,$zero	#j=0
	li.s $f6,0.0	#f6 = key
	li $t1,3
inner:
	beq $s1,$t1,exitinner
	li $t2,3
	mul $t2,$t2,$s5
	add $t2,$t2,$s1
	sll $t3,$t2,2
	add $t3,$t3,$s3
	l.s $f6, 0($t3)    #key=buck[k][i]
	addi $s2,$s1,-1
	
while:
	li $t4,3
	mul $t4,$t4,$s5
	add $t4,$t4,$s2
	sll $t5,$t4,2
	add $t5,$t5,$s3
	l.s $f7, 0($t5)    #f7=buck[k][j]
	c.lt.s $f6,$f7
	bc1f exitwhile
	bc1t L1
L1:
	blt $s2,$zero,exitwhile
	addi $t6,$t5,4
	s.s $f7, 0($t6)
	addi $s2,$s2,-1
	j while


exitwhile:
	addi $s2,$s2,1
	li $t4,3
	mul $t4,$t4,$s5
	add $t4,$t4,$s2
	sll $t5,$t4,2
	add $t5,$t5,$s3
	s.s $f6, 0($t5)
	addi $s1,$s1,1
	j inner
exitinner:
	addi $s5,$s5,1
	j insertion_sort
exitsort:
	li $t0,30
	lw $t1, n
	move $s1,$zero
	move $s2,$zero
	li.s $f0,0.0
	la $s0, arr
	la $s3, bucket
loop:
	beq $t0,$s1,exitloop
	beq $t1,$s2,exitloop
	sll $t3,$s1,2
	add $t3,$t3,$s3
	l.s $f1,0($t3)
	c.eq.s $f1,$f0
	bc1t L2
	sll $t4,$s2,2
	add $t4,$t4,$s0
	s.s $f1, 0($t4)
	addi $s1,$s1,1
	
	addi $s2,$s2,1
	
	j loop


exitloop:
	lw $t1, n
	move $s1,$zero
print:
	beq $t1,$s1,exit
	sll $t4,$s1,2
	add $t4,$t4,$s0
	li $v0,2
	l.s $f12, 0($t4)
	syscall
	
	li $a0, 32
    	li $v0, 11  
    	syscall

	addi $s1,$s1,1
	j print
	
exit:
	jr $ra

L2:   addi $s1,$s1,1
	j loop
