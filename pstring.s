# 211538863 Dana Danilenko

.section	.rodata			#read only data section

invalid:	.string	"invalid option\n"
_len: .string "%d"
_string: .string "%s"
format_for_31:             .string         "first pstring length: %d, second pstring length: %d\n"
format_for_32_33:       .string         "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_for_35:             .string         "length: %d, string: %s\n"
format_for_36:             .string          "length: %d, string: %s\n "
format_for_37:             .string          "compare result: %d\n"
_invalid:	                      .string	"invalid option!\n"
_invalid_35:                  .string            "invalid input!\n"






.text
.globl          pstrlen
.type           pstrlen, @function


pstrlen:
          pushq       %rbp
          movq        %rsp, %rbp
          xorq        %rax, %rax                  #%rax=0
          movzbq     (%rdi), %rax               # move the size of pstring
          movq       %rbp,  %rsp
          popq         %rbp
          ret



.text
.globl         pstrijcpy
.type           pstrijcpy, @function


 pstrijcpy:

       pushq       %rbp
       movq        %rsp, %rbp
       movq        %rdi,  %r8       #save pstring first


       call         pstrlen
       movq     %rax,  %rbx                 #save the lenght of pstring first
       movq       $0, %r9                       #counter
       movq         %rdi, %r11
        movq        %rsi,  %r10       #save pstring second
        movq        %rsi,  %rdi   


       call         pstrlen
       movq     %r11, %rdi
       movq     %rax,  %r11                 #save the lenght of pstring second
       addq        $1,  %rsi                  #pointer to the string- move one from lenght in pstring
       addq        $1,  %rdi                   #pointer to the string- move one from lenght in pstrin
       subq     $1, %r11
       subq      $1, %rbx

         #validation of index

        cmpq        %rcx, %rdx      #j<i?
         jg             .error

        cmpq       $0, %rdx      # i<0?
        js              .error

        cmpq       $0, %rcx        # j<0?
        js              .error

        cmpq       %rbx, %rcx      # len1<j?
        jg             .error

        cmpq       %rbx, %rdx        # len1<i?
        jg             .error

        cmpq       %r11, %rcx         # len2<j?
        jg            .error

        cmpq       %r11, %rdx              # len2<i?
        jg              .error

        movq       %rbp,  %rsp            
        popq         %rbp
        jmp              .i_loop
        ret


     .i_loop:
         cmpq        %rdx, %r9       #compare counter with i
         jne              .increment_i
         jmp             .j_loop


        .j_loop:
                cmpq        %rcx, %r9       #compare counter with j
                 jg                 .end_run_loop
                movb           (%rsi),  %r11b         #move new char insted old char
                movb           %r11b,  (%rdi)         #move new char insted old char
                jmp              .increment_j


        .increment_i:
            addq            $1, %rdi            #move pointer
            addq            $1, %rsi            #move pointer
            addq             $1, %r9               #counter++
            jmp                 .i_loop


         .increment_j:
            addq            $1, %rdi            #move pointer
            addq            $1, %rsi            #move pointer
            addq             $1, %r9               #counter++
            jmp                 .j_loop

            

         .end_run_loop:
            movq        %r8, %rax        #move pstring
            ret

            

          .error:            
              movq         $_invalid_35, %rdi
               xorq        %rax, %rax                  #%rax=0
               call           printf
               movq        %r8, %rax        #move pstring
               movq       %rbp,  %rsp              
               popq         %rbp
               ret

             


 .text
.globl         replaceChar
.type            replaceChar, @function


 replaceChar:
      pushq       %rbp
      movq        %rsp, %rbp
      movq        %rdi,  %r8       #save pstring
      movq         %rsi,  %r14         #save old char
       movq          %rdx,  %r15         #save new char

       call         pstrlen
       movq     %rax,  %rbx                 #save the lenght of pstring
       movq       $1, %r9                       #counter
       addq         $1,  %rdi                   #pointer to the string- move one from lenght in pstring
       movq       %rbp,  %rsp              
       popq         %rbp 
       jmp             .loop

     .loop:
        cmpq        %rbx, %r9       #compare counter with string len
        jg              .endLoop
        cmpb        (%rdi), %sil        #check if str[i] equal to old char
        jne              .inc
        movb           %dl,  (%rdi)         #move new char insted old char

        .inc:
            addq            $1, %rdi            #move pointer
            addq             $1, %r9               #counter++
            jmp                 .loop

         .endLoop:
            movq        %r8, %rax        #move pstring
            ret




 .text
.globl           swapCase
.type            swapCase, @function

 swapCase:
      pushq       %rbp
      movq        %rsp, %rbp
       movq        %rdi,  %r8       #save pstring

       call         pstrlen
       movq     %rax,  %rbx                 #save the lenght of pstring
       movq       $1, %r9                       #counter
       addq         $1,  %rdi                   #pointer to the string- move one from lenght in pstring
        movq       %rbp,  %rsp              
        popq         %rbp
        jmp             .loop_run
        ret

        

    .loop_run:
        cmpq        %rbx, %r9       #compare counter with string len
        jg              .end

        cmpb         $65, (%rdi)      #check if str[i] <65
        jl             .next_index

        cmpb         $122 , (%rdi)      #check if str[i] > 123
        jg                 .next_index

        cmpb          $96, (%rdi)       #check if str[i] > 96
        jg                .change_to_upper

        cmpb        $91, (%rdi)        #check if str[i] < 91
        jl                .change_to_lower
        jmp             .next_index                   #in case 6 chars between upper and lower
   

      .change_to_lower:
        addq           $32, (%rdi)
        jmp                .next_index

      .change_to_upper:
       subq           $32, (%rdi)
       jmp                .next_index


         .next_index:
            addq            $1, %rdi            #move pointer
            addq             $1, %r9               #counter++
            jmp                .loop_run

         .end:
            movq        %r8, %rax        #move pstring
            ret




.text
.globl          pstrijcmp
.type            pstrijcmp, @function


pstrijcmp:

        pushq   %rbp           # save old frame pointer
        movq    %rsp, %rbp
        movq    %rdi, %r12      # save first pstring
        movq    %rsi, %r13      # save second pstring 
        
        movq    %r12, %rdi  
        call        pstrlen
        movq    %rax, %r14      # first pstring len
     
        movq    %r13, %rdi         
        call       pstrlen
        movq    %rax, %r15       # second pstring len
     
        subq     $1, %r15
        subq     $1, %r14
        xorq     %rax, %rax

         #validation of index

        cmpq        %rcx, %rdx      #j<i?
         jg             .error_37
        
        cmpq       $0, %rdx      # i<0?
        js              .error_37

        cmpq       $0, %rcx        # j<0?
        js              .error_37

        cmpq       %r14, %rcx      # len1<j?
        jg             .error_37

        cmpq       %r14, %rdx        # len1<i?
        jg            .error_37

        cmpq       %r15, %rcx         # len2<j?
        jg            .error_37

        cmpq       %r15, %rdx          # len2<i?
        jg              .error_37


        addq    %rdx, %r12      # move string to i index
        addq    %rdx, %r13      # move string to i index
        xorq    %rax, %rax


    .lexi_cmp:
        addq    $1, %r12
        addq    $1, %r13
        xorq    %rax, %rax
        movzbq  (%r13), %r8
        cmpb    (%r12), %r8b            #compare str1[i] with str2[i]

        jg      .second_is_bigger
        jl      .second_is_smaller

        addq    $1, %rdx
        cmpb    %cl, %dl                    # compare i with j        
        jle     .lexi_cmp                       # while i <= j        
        xorq    %rax, %rax
        jmp     .end_37         

    .second_is_bigger:
        movq    $-1, %rax
        jmp     .end_37  


    .second_is_smaller:
        movq    $1, %rax
        jmp     .end_37  


    .end_37:
        movq    %rbp, %rsp
        popq    %rbp
        ret


    .error_37:
        movq    $_invalid_35, %rdi	 # invalid option format
        xorq    %rax, %rax
        call    printf 
        movq    $-2, %rax
        jmp     .end_37  
