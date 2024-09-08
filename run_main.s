# 211538863 Dana Danilenko

.section	.rodata			#read only data section
.align 16

_len: .string "%d"
_string: .string "%s"


.text
.global run_main
.type run_main, @function

run_main:
    
    movq        %rsp, %rbp      
    pushq       %rbp
    movq        %rsp, %rbp
    subq        $544, %rsp
    xorq        %rax, %rax          #%rax=0
    
    movq        $_len, %rdi                  #get first len
    leaq           -512(%rbp), %rsi        #alocation 
    call            scanf
    movq        -512(%rbp), %r12        #save caller  %r12= len of first sring
    
     movq        $_string, %rdi             #get first string
    leaq           -511(%rbp), %rsi        #alocation 
     xorq        %rax, %rax                  #%rax=0
    call            scanf
    movq        -511(%rbp), %r13       #save   %r13= first string
    
    
     movq        $_len, %rdi                  #get second len
    leaq           -256(%rbp), %rsi        #alocation 
    call            scanf
    movq        -256(%rbp), %r14        #save  %r12= len of second sring
    
     movq        $_string, %rdi             #get second string
    leaq           -255(%rbp), %rsi        #alocation 
     xorq        %rax, %rax                  #%rax=0
    call            scanf
    movq        -255(%rbp), %r15       #save caller  %r13= second string
    
    
     movq        $_len, %rdi                  #get idex 
    leaq           -516(%rbp), %rsi        #alocation 
    call            scanf
    movq        -516(%rbp), %rbx        #save caller  %rbx= index
    
    
   movl         -516(%rbp),  %edi                       #index
   leaq         -512(%rbp),  %rsi                           #first pstring
   leaq          -256(%rbp),  %rdx                      #second pstring
   
   
   
     xorq        %rax, %rax                  #%rax=0
     call           run_func
     movq       %rbp,  %rsp
     popq         %rbp
     ret
     
     
  
