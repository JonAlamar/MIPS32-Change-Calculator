## CS 254 Program 7 
##
## Compute change due given a number of cents.
##
## Jonathan Gargano
## April 1, 2021

## Register use table:
## $t2 cents remaining
## $t3 quarters
## $t4 dimes
## $t5 nickels
## $t6 pennies
## $t7 divisor


.globl main
.text

main: 

la $a0, askint               #load askint string
li $v0, 4                    #load syscall code print string
syscall                      #print askint
li $v0, 5                    #load syscall code to read integer
syscall                      #Read number of cents
move $t2, $v0                #move input into cents reg
bltz $t2, negtv              #if input is not positive jump to error
blt $t2, 25, dimes           #if cents less than 25 check dimes

quarters:
li $t7, 25
div $t2, $t7                 #divide cents by 25
mflo $t3                     #number of quarters = cents / 25
mfhi $t2                     #cents remaining = cents % 25

dimes:
blt $t2, 10, nickels         #if cents less than 10 check nickels
li $t7, 10
div $t2, $t7                 #divide cents by 10
mflo $t4                     #number of dimes = cents / 10
mfhi $t2                     #cents remaining = cents % 10

nickels:
blt $t2, 5, pennies          #if cents less than 5 check pennies
li $t7, 5
div $t2, $t7                 #divide cents by 5
mflo $t5                     #number of nickels = cents / 5
mfhi $t2                     #cents remaining = cents % 5

pennies:
move $t6, $t2                #number of pennies = cents remaining
output: la $a0, prntquarters #print quarters output string
li $v0, 4                    #load syscall code print string
syscall
move $a0, $t3                #print number of quarters
li $v0, 1                    #load syscall to print int
syscall
la $a0, prntdimes            #print dimes output string
li $v0, 4                    #load syscall code print string
syscall
move $a0, $t4                #print number of dimes
li $v0, 1                    #load syscall to print int
syscall
la $a0, prntnickels          #print nickels output string
li $v0, 4                    #load syscall code print string
syscall
move $a0, $t5                #print number of nickels
li $v0, 1                    #load syscall to print int
syscall
la $a0, prntpennies          #print pennies output string
li $v0, 4                    #load syscall code print string
syscall
move $a0, $t6                #print number of pennies
li $v0, 1                    #load syscall to print int
syscall
la $a0, newline              #print two newlines for formatting
li $v0, 4                    #load syscall code print string
syscall
syscall
j end                        #jump to end
negtv: la $a0, errormsg      #load error message
li $v0, 4                    #load syscall code print string
syscall                      #error message
end: li $v0, 10              #load syscall to end program
syscall                      #end of program


.data
askint: .asciiz "Enter number of cents: "
errormsg: .asciiz "Number must be positive."
prntquarters: .asciiz "Number of quarters : "
prntdimes: .asciiz "\nNumber of dimes : "
prntnickels: .asciiz "\nNumber of nickels : "
prntpennies: .asciiz "\nNumber of pennies : "
newline : .asciiz "\n"