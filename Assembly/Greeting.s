.data
string: .asciz "Hello\n"

.text
.global _greeting
.align 2
_greeting:
    adrp x0, string@PAGE
    bl _printf

