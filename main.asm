# jahnavi arora

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################

.text

# Part I
compare_to:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)

move $s0, $a0 #c1
move $s1, $a1 #c2

 addi $s0, $s0, 4
 lhu $t0, 0($s0) #fame c1
 addi $s0, $s0, 2
 lhu $t1, 0($s0) #wait time c1

 addi $s1, $s1, 4
 lhu $t2, 0($s1) #fame c2
 addi $s1, $s1, 2
 lhu $t3, 0($s1) #wait time c2

 li $t6, 10
 mul $t4, $t1, $t6 #c1 priority
 add $t4, $t4, $t0
 mul $t5, $t3, $t6 #c2 priority
 add $t5, $t5, $t2

 blt $t4, $t5, c1_less
 bgt $t4, $t5, c2_less
 blt $t0, $t2, c1_less
 bgt $t0, $t2, c2_less
 li $v0, 0
j pt1end

c2_less:
 li $v0, 1
 j pt1end

c1_less:
 li $v0, -1
 j pt1end

pt1end:
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

 jr $ra

# Part II
init_queue:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)

move $s0, $a0 #queue
move $s1, $a1 #max_size
blez $s1, invalid_input_pt2

li $t0, 0
sh $t0, 0($s0)
addi $s0, $s0, 2
sh $s1, 0($s0)
addi $s0, $s0, 2

li $t3, 8 #number of bytes per customer
li $t1, 0 #counter
pt2_initalize:
 li $t2, 0 #counter till 8
 storing_0s:
  sb $t0, 0($s0)
  addi $s0, $s0, 1
  addi $t2, $t2, 1
  blt $t2, $t3, storing_0s
 reached_8:
  addi $t1, $t1, 1
  blt $t1, $s1, pt2_initalize
move $v0, $s1
j pt2end

invalid_input_pt2:
li $v0, -1

pt2end:
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part III
memcpy:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)

move $s0, $a0 #src
move $s1, $a1 #dest
move $s2, $a2 #n
blez $s2, invalid_input_pt3
move $v0, $s2

li $t0, 0
copy_loop:
 lbu $t1, 0($s0)
 sb $t1, 0($s1)
 addi $s0, $s0, 1
 addi $s1, $s1, 1
 addi $t0, $t0, 1
 blt $t0, $s2, copy_loop
 j pt3end
 
invalid_input_pt3:
li $v0, -1

pt3end:
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part IV
contains:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)

move $s0, $a0 #queue
move $s1, $a1 #customer id
lhu $s2, 0($s0) #size
addi $s0, $s0, 4 #move to beg of customer array

li $t0, 0 #counter
contains_loop:
 lw $t1, 0($s0)
 beq $t1, $s1, id_found
 addi $s0, $s0, 8 #moves to next customer
 addi $t0, $t0, 1
 blt $t0, $s2, contains_loop
li $v0, -1
j pt4end

id_found:
 addi $t0, $t0, 1
 li $t1, 0 #levelcounter
 li $t2, 3
 loop_for_level:
  div $t0, $t2
  addi $t1, $t1, 1
  mflo $t3
  beqz $t3, level_found
  move $t0, $t3
  j loop_for_level
 level_found:
  move $v0, $t1
 
pt4end:
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4

jr $ra

# Part V
enqueue:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #queue
move $s1, $a1 #customer
lhu $s2, 0($s0) #size
addi $s0, $s0, 2
lhu $s3, 0($s0) #max size

beq $s2, $s3, invalid_input_pt5
addi $s0, $s0, 2
jal contains 
bgtz $v0, invalid_input_pt5
li $v0, 1

insert_to_end:
 li $t1, 8
 mul $t0, $s2, $t1
 add $s0, $s0, $t0
 move $a1, $s0
 move $s0, $a0 #resets s0 back to beginning of queue
 move $a0, $s1
 li $a2, 8
 jal memcpy
 
 addi $s0, $s0, 4
 move $s5, $s2 #index of added customer
 sorting_loop: 
  beqz $s5, else
   addi $s6, $s5, -1
   li $t2, 3
   div $s6, $t2
   mflo $s6 #index of parent (n-1/3)
   li $t2, 8
   mul $s3, $s5, $t2 # 8 * index1
   add $s3, $s3, $s0 # 8 * index1 + baseaddress (START OF CUSTOMER 1)
   mul $s4, $s6, $t2
   add $s4, $s4, $s0 #(START OF CUSTOMER 2)
  
   move $a0, $s3 #customer 1
   move $a1, $s4 #customer 2
   jal compare_to
   blez $v0, else
    addi $sp, $sp -8
    move $a1, $sp #dest
    move $a0, $s3 #src
    li $a2, 8 
    jal memcpy #c1 is stored in sp
    
    move $a1, $s3
    move $a0, $s4
    jal memcpy #c2 is stored in c1
    
    move $a1, $s4
    move $a0, $sp
    jal memcpy #sp is cored in c2
    
    addi $sp, $sp, 8
    move $s5, $s6
    j sorting_loop
 
  else:
   addi $s2, $s2, 1 #adds 1 to the size of the array
   li $v0, 1
   j pt5end

invalid_input_pt5:
 li $v0, -1

pt5end:
 move $v1, $s2
 
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s6, 0($sp)
 addi $sp, $sp, 4
 lw $s5, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 jr $ra

# Part VI
heapify_down:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $s7, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #queue address
move $s1, $a1 #index

lhu $s2, 0($s0) #size
bge $s1, $s2, invalid_input_pt6
bltz $s1, invalid_input_pt6
addi $s0, $s0, 4 #goes to beginnging of queue
li $s7, 0 #number of swaps counter
heapify_down_loop:
 bge $s1, $s2, heapify_down_loop_done
 li $t0, 3
 mul $s3, $s1, $t0 
 addi $s3, $s3, 1 #left
 mul $s4, $s1, $t0 
 addi $s4, $s4, 2 #mid
 mul $s5, $s1, $t0
 addi $s5, $s5, 3 #right
 move $s6, $s1 #largest
 blt $s3, $s2, check_left
 j check_mid
 check_left:
  li $t0, 8
  mul $a0, $s3, $t0
  add $a0, $a0, $s0 #customer 1 (left)
  mul $a1, $s6, $t0
  add $a1, $a1, $s0 #customer 2 (largest)
  jal compare_to
  blez $v0, check_mid
  move $s6, $s3 #if [left]>[largest], largest = left
 check_mid:
  bge $s4, $s2, check_right
  li $t0, 8
  mul $a0, $s4, $t0
  add $a0, $a0, $s0 #customer 1 (mid)
  mul $a1, $s6, $t0
  add $a1, $a1, $s0 #customer 2 (largest)
  jal compare_to
  blez $v0, check_right
  move $s6, $s4
 check_right:
  bge $s5, $s2, check_largest
  li $t0, 8
  mul $a0, $s5, $t0
  add $a0, $a0, $s0 #customer 1 (right)
  mul $a1, $s6, $t0
  add $a1, $a1, $s0 #customer 2 (largest)
  jal compare_to
  blez $v0, check_largest
  move $s6, $s5
 check_largest:
  beq $s1, $s6, heapify_down_loop_done
  li $t0, 8
  mul $s4, $s1, $t0
  add $s4, $s4, $s0 #address of s1
  mul $s3, $s6, $t0
  add $s3, $s3, $s0 #address of s6
  addi $sp, $sp, -8
  
  move $a1, $sp
  move $a0, $s3
  li $a2, 8
  jal memcpy
  
  move $a1, $s3
  move $a0, $s4
  jal memcpy
  
  move $a1, $s4
  move $a0, $sp
  jal memcpy  #completes the swap
  addi $sp, $sp, 8 
  move $s1, $s6
  addi $s7, $s7, 1
  j heapify_down_loop
  
heapify_down_loop_done: 
 move $v0, $s7
 j pt6end
 
invalid_input_pt6:
 li $v0, -1

pt6end:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s7, 0($sp)
 addi $sp, $sp, 4
 lw $s6, 0($sp)
 addi $sp, $sp, 4
 lw $s5, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 
 jr $ra

# Part VII
dequeue:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #queue
move $s1, $a1 #dequeued customer
lhu $s2, 0($s0) #size
beqz $s2, invalid_input_pt7
addi $s0, $s0, 4
#step 1: take customer[0] copies into dequed_customer
 move $a0, $s0 #source
 move $a1, $s1 #destination
 li $a2, 8
 jal memcpy
#step 2: copy customer[size-1] to customer [0]
 addi $s3, $s2, -1
 li $t0, 8
 mul $s3, $s3, $t0
 add $s3, $s3, $s0 #starting of customer[size-1]
 
 move $a0, $s3 
 move $a1, $s0
 li $a2, 8
 jal memcpy
#step 3: changes size to size-1 in the queue
 addi $s2, $s2, -1
 addi $s0, $s0, -4
 sh $s2, 0($s0)

#step 4: calls heapify_down
 move $a0, $s0
 li $a1, 0
 jal heapify_down
 
 move $v0, $s2
 j pt7end

invalid_input_pt7:
 li $v0, -1

pt7end:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4

 jr $ra

# Part VIII
build_heap:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #queue
lhu $s1, 0($s0) #size
beqz $s1, zero_size

addi $s2, $s1, -1
li $t0, 3
div $s2, $t0
mflo $s2 #index
li $s3, 0 #return val
heapify_loop_pt8:
 move $a0, $s0
 move $a1, $s2
 jal heapify_down
 add $s3, $s3, $v0 #summing return vals
 addi $s2, $s2, -1 
 bgez $s2, heapify_loop_pt8

move $v0, $s3
j pt8end

zero_size:
 li $v0, 0

pt8end:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 
 jr $ra

# Part IX
increment_time:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0
move $s1, $a1 #delta_mins
move $s2, $a2 #fame level

lhu $s3, 0($s0) #sizze
beqz $s3, invalid_input_pt9
blez $s1, invalid_input_pt9
blez $s2, invalid_input_pt9
addi $s0, $s0, 4
li $s4, 0 #returnval
li $t0, 0
incrementingloop: 
 addi $s0, $s0, 4
 lhu $t1, 0($s0) #fame
 bge $t1, $s2, increment_waittime
 add $t1, $t1, $s1 #fame = fame + delta_mins
 sh $t1, 0($s0)
 increment_waittime:
  addi $s0, $s0, 2
  lhu $t1, 0($s0)
  add $t1, $t1, $s1
  add $s4, $s4, $t1
  sh $t1, 0($s0)
  addi $s0, $s0, 2
  addi $t0, $t0, 1
  blt $t0, $s3, incrementingloop
 jal build_heap
 div $s4, $s3
 mflo $v0
 j pt9end
 
invalid_input_pt9:
 li $v0, -1

pt9end:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4

 jr $ra

# Part X
admit_customers:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0
move $s1, $a1 #max admits
move $s2, $a2 #admitted
li $s3, 0 #loop counter 
lhu $s4, 0($s0) #size

beqz $s4, invalid_input_10
blez $s1, invalid_input_10

admittingloop:
 move $a0, $s0
 move $a1, $s2
 jal dequeue
 addi $s3, $s3, 1
 bge $s3, $s1, done_admitting
 bge $s3, $s4, done_admitting
 addi $s2, $s2, 8
 j admittingloop
done_admitting:
 move $v0, $s3
 j pt10end
invalid_input_10:
 li $v0, -1

pt10end:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4

 jr $ra

# Part XI
seat_customers:
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $s7, 0($sp)
addi $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0 #customers_admitted
move $s1, $a1 #size
move $s2, $a2 #budget

blez $s1, invalid_input_pt11
blez $s2, invalid_input_pt11

li $s3, 0 #temp fame 
li $s4, 0 #temp waittime
li $s5, 0 #final waittime
li $s6, 0 #final fame
li $s7, 0 #final v0

li $t0, 1 #i
li $t8, 1 #2^n
li $s3, 0 #counter
get_2n:
 beq $s3, $s1, forloop_pt11
 sll $t8, $t8, 1
 addi $s3, $s3, 1
 j get_2n
forloop_pt11:
 move $t1, $t0 #t0 = t1
 li $t2, 0 #index counter
 get_indexes:
  beq $t2, $s1, done_with_indexes #########
  li $t3, 2
  div $t1, $t3
  mfhi $t3 #reminader
  mflo $t1 #quotient 
  #beqz $t1, done_with_indexes
  li $t4, 1
  beq $t3, $t4, included_val
  addi $t2, $t2, 1
  j get_indexes
  included_val:
   move $s0, $a0
   li $t4, 8
   mul $t5, $t2, $t4
   addi $t5, $t5, 4
   add $s0, $s0, $t5
   lhu $t6, 0($s0) #fame at index
   add $s3, $s3, $t6
   addi $s0, $s0, 2
   lhu $t6, 0($s0) #waittime at index
   add $s4, $s4, $t6
   addi $t2, $t2, 1
   j get_indexes
  done_with_indexes:
   bgt $s4, $s2, endingpart
   ble $s3, $s6, endingpart
   move $s5, $s4
   move $s6, $s3
   move $s7, $t0
   endingpart:
    li $s3, 0
    li $s4, 0
    addi $t0, $t0, 1
    blt $t0, $t8, forloop_pt11
    j done_pt11
done_pt11:
 move $v0, $s7
 move $v1, $s6
 j end_pt11
 
invalid_input_pt11:
 li $v0, -1
 li $v1, -1
end_pt11:
 lw $ra, 0($sp)
 addi $sp, $sp, 4
 lw $s7, 0($sp)
 addi $sp, $sp, 4
 lw $s6, 0($sp)
 addi $sp, $sp, 4
 lw $s5, 0($sp)
 addi $sp, $sp, 4
 lw $s4, 0($sp)
 addi $sp, $sp, 4
 lw $s3, 0($sp)
 addi $sp, $sp, 4
 lw $s2, 0($sp)
 addi $sp, $sp, 4
 lw $s1, 0($sp)
 addi $sp, $sp, 4
 lw $s0, 0($sp)
 addi $sp, $sp, 4
 jr $ra

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
