# 211538863 Dana Danilenko

.section	.rodata			#read only data section
.align 16


invalid:	.string	"invalid option\n"
_len: .string "%d"
_string: .string "%s"
format_for_31:             .string         "first pstring length: %d, second pstring length: %d\n"
format_for_32_33:       .string         "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_for_35:             .string         "length: %d, string: %s\n"
format_for_36:             .string          "length: %d, string: %s\n"
format_for_37:             .string          "compare result: %d\n"
_invalid:	                      .string	"invalid option!\n"
_invalid_35:                  .string            "invalid input!\n"


      
.jump_table:
    .quad       .invalid
    .quad       .index_31 
    .quad       .index_32_33
    .quad       .index_32_33
    .quad       .invalid
    .quad       .index_35
    .quad       .index_36
    .quad       .index_37
    
      
.text
.global             run_func
.type                run_func,  @function
.extern              pstrlen

run_func:
        pushq   %rbp            # save old frame pointer
        movq    %rsp, %rbp
        sub     $16,%rsp
        leaq    -30(%edi), %r8      # compute value-30 to match the jump table
        
        cmpq    $4, %r8             # if the index is 34 - invalid
        je      .invalid 
        
        cmpq    $0, %r8 
        jle      .invalid               # if the index is less then 31 (1)- invalid
        
        cmpq    $8, %r8         # if equal or greater then 38 - invalid
        jge     .invalid
        
        jmp     *.jump_table( ,%r8,8)
        movq    %rbp, %rsp
        pop     %rbp
        ret
          
        .invalid:
                 movq         $_invalid, %rdi
                xorq        %rax, %rax                  #%rax=0
                call           printf
                 movq       %rbp,  %rsp
                 popq         %rbp
                 ret
              
          
            .index_31:
                 movq        %rsi ,%r12           #save first pstrint in callee
                  movq        %rdx, %r13          #save second pstrint in callee
                  movq        %r12, %rdi          #save in first argument of pstrlen
                  call            pstrlen
                  movq         %rax,  %rsi          #save the return
                  movq         %r13, %rdi          #save in second argument of pstrlen
                  call             pstrlen
                  movq         %rax,  %rdx            #save the return
                  movq          $format_for_31,  %rdi 
                  call               printf
                  movq       %rbp,  %rsp
                  popq         %rbp
                 ret
                 
                 
                 
           
          
           .index_32_33:
                 movq        %rsi ,%r12           #save first pstrint in callee
                 movq        %rdx, %r13          #save second pstrint in callee
                 movq         $_string,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call             scanf
                 movq         (%rsp),  %r14           #save old char  
                 
                                                                                 
                 movq         $_string,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call              scanf
                 movq          (%rsp),  %r15           #save new char
                 
                 movq           %r12, %rdi                  #save pstring first
                 movq          %r14, %rsi                    #save old char
                 movq           %r15, %rdx                    #save new char
                 call               replaceChar
                  
                   
                 movq           %r13, %rdi                  #save pstring second
                 movq           %r14, %rsi                    #save old char
                 movq           %r15, %rdx                    #save new char
                 call                replaceChar
                  
                 addq           $1, %r12
                 addq          $1, %r13                                   # point to string. 
                 movq         $format_for_32_33, %rdi 
                 movq           %r12, %rcx                    #save first string
                 movq           %r13, %r8                  #save second string
                 
                 call                printf
                 movq       %rbp,  %rsp
                 popq        %rbp
                 xorq        %rax, %rax                  #%rax=0
                 ret
                   
          
           
           .index_35:
                 movq        %rsi ,%r12           #save first pstrint in callee
                 movq        %rdx, %r13          #save second pstrint in callee
                 movq         $_len,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call             scanf
                 movq         (%rsp),  %r14           #save index i
                 
                 movq         $_len,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call             scanf
                 movq         (%rsp),  %r15           #save index j
                     
                     
                 movq           %r12, %rdi                  #save pstring first
                 movq           %r13, %rsi                #save pstring second
                 movq           %r14, %rdx                   #save index i
                 movq           %r15, %rcx                  #save index j
                 call               pstrijcpy
                 
               
                 movq        %r12, %rdi          #save in first argument of pstrlen
                 call            pstrlen
                 movq         %rax,  %rsi          #save the return
                 addq           $1, %r12
                 movq        %r12, %rdx 
                 movq          $format_for_35,  %rdi 
                 call              printf
                 
                 movq        %r13, %rdi          #save in first argument of pstrlen
                 call            pstrlen
                 movq         %rax,  %rsi          #save the return
                  addq           $1, %r13
                  movq        %r13, %rdx 
                  movq          $format_for_35,  %rdi 
                  call              printf
                  
                 movq       %rbp,  %rsp
                 popq         %rbp
                 xorq        %rax, %rax                  #%rax=0
                 ret
           
           
           .index_36:
                movq        %rsi ,%r12           #save first pstrint in callee
                movq        %rdx, %r13          #save second pstrint in callee
                
                 movq        %r12, %rdi          #save in first argument of pstrlen
                 call            pstrlen
                 movq         %rax,  %rsi          #save the return
                 
                
                movq           %r12, %rdi                  
                call               swapCase
                addq           $1, %r12
                movq           %r12, %rdx
                movq          $format_for_36,  %rdi 
                call               printf
                
                
                 movq        %r13, %rdi          #save in first argument of pstrlen
                 call            pstrlen
                 movq         %rax,  %rsi          #save the return
                 
                movq           %r13, %rdi                  
                call               swapCase
                addq           $1, %r13
                movq           %r13, %rdx
                movq          $format_for_36,  %rdi 
                call               printf
                 
                 movq       %rbp,  %rsp
                 popq         %rbp
                 xorq        %rax, %rax                  #%rax=0
                 ret
                
      
           .index_37:
                  movq       %rsi ,%r12           #save first pstrint in callee
                 movq        %rdx, %r13          #save second pstrint in callee
                 movq         $_len,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call             scanf
                 movq         (%rsp),  %r14           #save index i
                 
                 movq         $_len,  %rdi   
                 leaq           (%rsp),  %rsi
                 xorq           %rax, %rax                  #%rax=0
                 call             scanf
                 movq         (%rsp),  %r15           #save index j
                     
                     
                 movq           %r12, %rdi                  #save pstring first
                 movq           %r13, %rsi                  #save pstring second
                 movq           %r14, %rdx                 #save index i
                 movq           %r15, %rcx                 #save index j
                 call                 pstrijcmp
            
                 movq    %rax, %rsi
                movq    $format_for_37, %rdi 
                call    printf
                
                 movq       %rbp,  %rsp
                 popq         %rbp
                 xorq        %rax, %rax                  #%rax=0
                 ret
        


        