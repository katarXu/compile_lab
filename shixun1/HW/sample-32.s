	.file	"sample.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp				/*32位对应long %ebp入栈 %esp自减 subl $4, %esp; movl $ebp, (%esp)  */
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp			/*存储基址*/
	.cfi_def_cfa_register 5
	subl	$16, %esp			/*分配空间*/
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$4, -4(%ebp)			/*第一个参数等于4*/
	cmpl	$0, -4(%ebp)			/*和0比较*/
	je	.L2				/*jump equal*/
	addl	$4, -4(%ebp)			
	jmp	.L3
.L2:
	sall	$2, -4(%ebp)
.L:
	movl	$0, %eax
	leave					/*movl %ebp, %esp; popl %ebp(movl (%esp), %ebp; addl $4, %esp)*/
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret					/*popl %eip*/
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB1:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE1:
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
