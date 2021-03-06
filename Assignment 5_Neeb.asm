; multi-segment executable file template.
.MODEL  small
.STACK  100h
   
.DATA
    ; add your data here!
    welcome_msg DB      "*** Spacely Sprockets Order Form ***$",lf,cr,"Please enter the following data in correct format.$"
    file_msg    DB      "Struct written to file C:\asm\test.txt$"
    bye_msg     DB      "Program Complete!$"   
    
    str1        DB      "Order Number: $"
    str2        DB      "Customer ID: $"
    str3        DB      "Sprocket Type: $"
    str4        DB      "Part Quantity: $"
    str5        DB      "Order Total: $"
    
    file_buf    DB      24 DUP (?)                ;buffer zone
    file_name   DB      'C:\asm\test.txt',00h       ;ASCIIZ string
    dir_name    DB      'C:\asm',00h                ;ASCIIZ string
    
    DATASTRUCT   LABEL   BYTE
    MaxLen       DB      24
    ActLen       DB      0
    DataFld      DB      24 DUP(?)
    CRLFBuf      DB      0Dh,0Ah,'$'

 
    handle1      DW      0
     
;-----------------------------------------------------
; err_chk routine related data
;-----------------------------------------------------

      cr        EQU     0Dh     ;carriage return
      lf        EQU     0Ah     ;line feed
      errtbl    DW      0,err1,err2,err3,err4,err5,err6
                DW      5 DUP (0)
                DW      err12
      err1      DB      'Invalid function number',lf,cr,'$'
      err2      DB      'File not found',lf,cr,'$'
      err3      DB      'Path not found',lf,cr,'$'
      err4      DB      'Too many open files',lf,cr,'$'
      err5      DB      'Access denied',lf,cr,'$'
      err6      DB      'Invalid handle',lf,cr,'$'
      err12     DB      'Invalid access code',lf,cr,'$'

        
.CODE
start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; add your code here     
    
    ;Print welcome message
    lea     dx,welcome_msg
    mov     ah,09h
    int     21h
     
    call    display_newline 
                             
    call    create_directory
    
    call    create_file
               
    call    display_newline               
                             
    call    read_data
    
    call    display_newline
    
    call    close_file     
    
    ;Print file message
    call    display_newline
    lea     dx,file_msg
    mov     ah,09h
    int     21h        
    
    call    display_newline                                                       
    
    call    display_newline
      
    call    read_file
         
    ;Print bye message
    call    display_newline
    lea     dx,bye_msg
    mov     ah,09h
    int     21h
          
    mov ax, 4c00h ; exit to operating system.
    int 21h                      
     
 ;--------------------------------------
 ; display_newline - used simply to crlf
 ;--------------------------------------    
  display_newline   PROC    near
    mov dx,13
    mov ah,2
    int 21h  
    mov dx,10
    mov ah,2
    int 21h
    ret
  display_newline   ENDP
         
 ;--------------------------------------
 ; read_data - used to read data into struct
 ;--------------------------------------
  read_data         PROC    near
   ;Display prompt 1
    lea     dx, str1                  
    mov     ah,09h
    int     21h
       
   ;Write prompt 1 to file
    mov     cx,14                ;actual bytes to write
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,str1              ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
   
    call    get_input     
   
   ;Write input 1 to file 
    mov     cx,bx
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,DATASTRUCT+2      ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
   ;Write CRLF to file 
    mov     cx,2
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,CRLFbuf           ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
    call    display_newline
    
    ;Display prompt 2
    lea     dx, str2                  
    mov     ah,09h
    int     21h
       
   ;Write prompt 2 to file
    mov     cx,13                ;actual bytes to write
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,str2              ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
   
    call    get_input     
   
   ;Write input 2 to file 
    mov     cx,bx
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,DATASTRUCT+2      ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
   ;Write CRLF to file 
    mov     cx,2
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,CRLFbuf           ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error

    call    display_newline
    
    ;Display prompt 3
    lea     dx, str3                  
    mov     ah,09h
    int     21h
       
   ;Write prompt 3 to file
    mov     cx,15                ;actual bytes to write
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,str3              ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
   
    call    get_input     
   
   ;Write input 3 to file 
    mov     cx,bx
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,DATASTRUCT+2      ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
   ;Write CRLF to file 
    mov     cx,2
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,CRLFbuf           ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error

    call    display_newline
    
    ;Display prompt 4
    lea     dx, str4                  
    mov     ah,09h
    int     21h
       
   ;Write prompt 4 to file
    mov     cx,15                ;actual bytes to write
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,str4              ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
   
    call    get_input     
   
   ;Write input 4 to file 
    mov     cx,bx
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,DATASTRUCT+2      ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
   ;Write CRLF to file 
    mov     cx,2
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,CRLFbuf           ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error

    call    display_newline
    
    ;Display prompt 5
    lea     dx, str5                  
    mov     ah,09h
    int     21h
       
   ;Write prompt 5 to file
    mov     cx,13                ;actual bytes to write
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,str5              ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
   
    call    get_input     
   
   ;Write input 5 to file 
    mov     cx,bx
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,DATASTRUCT+2      ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    
   ;Write CRLF to file 
    mov     cx,2
    mov     ah,40h               ;write to file
    mov     bx,handle1           ;file handle
    lea     dx,CRLFbuf           ;address to actual data &crlf&$
    int     21h
    call    err_chk              ;exit on error
    ret   
  read_data         ENDP         
          
 ;--------------------------------------
 ; get_input - used to read data into struct
 ;--------------------------------------
  get_input      PROC    near
    lea     dx,DATASTRUCT
    mov     ah,0ah              ;request input
    int     21h
    mov     bh,00h
    mov     bl,ActLen
    mov     dataFld[bx],00h     ;CRLF at end
    ret
  get_input      ENDP
        
 ;--------------------------------------
 ; create_directory - used to create the file's directory
 ;--------------------------------------
  create_directory  PROC    near
    mov     ax, SEG dir_name
    mov     ds, ax
    mov     dx, OFFSET dir_name ;pointer to directory name        
    mov     ah,39h             ;Create directory
    int     21h
    call    err_chk            ;trap any errors which occur
    ret  
  create_directory  ENDP                        
       
 ;--------------------------------------
 ; create_file - used to create file
 ;--------------------------------------
  create_file       PROC    near
    mov     ah,3Ch          ;Create file
    mov     cx,00           ;"normal" attribute
    lea     dx,file_name    ;pointer to name of file
    int     21h
    call    err_chk         ;so, exit on error
    mov     handle1,ax      ;otherwise, this is our handle
    ret   
  create_file       ENDP      
 
 ;--------------------------------------
 ; close_file - closes the file after data manipulation
 ;--------------------------------------    
  close_file   PROC    near
    mov     ah,3Eh          ;close file
    mov     bx,handle1      ;file handle
    int     21h
    call    err_chk         ;exit on error
    ret
  close_file   ENDP
                        
 ;--------------------------------------
 ; read_file
 ;--------------------------------------
  read_file        PROC    near
    mov     ah,3Dh          ;open file
    mov     al,000b         ;read access
    lea     dx,file_name    ;address
    int     21h
    call    err_chk         ;exit on error
    mov     handle1,ax      ;save file handle

   ;Get length of file
    mov     ah,42h          ;move pointer
    mov     al,02h          ;offset from end of file
    mov     bx,handle1      ;file handle
    xor     cx,cx           ;set cx = 0
    xor     dx,dx           ;set dx = 0
    int     21h             ;file length in DS:AX
    push    ax              ;AX = file length
                                        
    call    err_chk

   ;Reset file pointer to beginning of file
    mov     ah,42h          ;move pointer
    mov     al,00h          ;set at start of file
    mov     bx,handle1      ;file handle
    xor     cx,cx           ;CX = 0
    xor     dx,dx           ;DX = 0
    int     21h
    call    err_chk

   ;Read file
    mov     ah,3Fh          ;read file
    mov     bx,handle1      ;file handle
    pop     cx              ;read byes
    lea     dx,file_buf     ;address
    int     21h
    call    err_chk

   ;Display data in file buffer
    mov     ah,40h          ;write to device
    mov     bx,1            ;device = screen
    lea     dx,file_buf     ;address
    int     21h

    ret
  read_file        ENDP                        
                        
 ;--------------------------------------
 ; err_chk routine
 ;--------------------------------------
 err_chk        PROC    near
    jnc     exitproc        ;no error then exit procedure
    mov     bx,ax
    mov     ah,9            ;display string
    mov     dx,errtbl[bx]   ;message offset
    int     21h
    mov     ax,4C00h        ;terminate on error
    int     21h
    exitproc:   ret
 err_chk        ENDP                      

 END     start                   
                    
end start ; set entry point and stop the assembler.