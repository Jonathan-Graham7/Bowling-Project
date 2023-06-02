import math
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

a=int(input())             #inputs
b=int(input())
c=int(input())
die_a=[a, math.sqrt(a), math.factorial(a)]             #dice rolls
die_b=[b, math.sqrt(b), math.factorial(b)]
die_c=[c, math.sqrt(c), math.factorial(c)]

operators=["+","-"]

def solutions(x,y):         #creates solutions of equations
    num=0
    solutions=[]
    while num<len(x):         #runs through variations of input 1
        var=0
        while var<len(y):          #runs through variations of input 2
            for i in operators:            #runs through variations of operators
                entry_1=eval('('+str(x[num])+i+str(y[var])+')')
                entry_2=eval('('+str(y[var])+i+str(x[num])+')')
                if entry_1==entry_2:                         #insures operators are used both directions, but not repeated
                    solutions+=[eval('('+str(x[num])+i+str(y[var])+')')]
                else:
                    solutions+=[eval('('+str(x[num])+i+str(y[var])+')')]
                    solutions+=[eval('('+str(y[var])+i+str(x[num])+')')]
            var+=1
        num+=1
    return solutions

def equations(x,y):                     #creates equations
    num=0
    equations=[]
    while num<len(x):         #runs through variations of input 1
        var=0
        while var<len(y):          #runs through variations of input 2
            for i in operators:            #runs through variations of operators
                entry_1=eval('('+str(x[num])+i+str(y[var])+')')
                entry_2=eval('('+str(y[var])+i+str(x[num])+')')
                if entry_1==entry_2:                         #insures operators are used both directions, but not repeated
                    equations+=['('+str(x[num])+i+str(y[var])+')']
                else:
                    equations+=['('+str(x[num])+i+str(y[var])+')']
                    equations+=['('+str(y[var])+i+str(x[num])+')']
            var+=1
        num+=1
    return equations

def solution_options(x,y):           #square root and factorial each output from first two variables
    options=solutions(x,y)
    original=solutions(x,y)
    var=0
    while var<len(original):
        number=original[var]
        if 0<=number:
            options.append(math.sqrt(number))
            if number==int(number):
                number=int(number)
                number=math.factorial(number)
                options.append(number)
        var+=1
    return options

def equation_options(x,y):           #square root and factorial each output equation from first two variables
    options=equations(x,y)
    original=equations(x,y)
    var=0
    while var<len(original):
        number=eval(original[var])
        if 0<=number:
            options.append('math.sqrt'+original[var])
            if number==int(number):
                options.append('math.factorial'+original[var])
        var+=1
    return options

def final_s(x,y,z):             #restricts answers
    alot=solution_options(solution_options(x,y),z)
    final=[]
    var=0
    while var<len(alot):
        if alot[var]==int(alot[var]):
            if -10<=alot[var]<0 or 0<alot[var]<=10:
                if alot[var] not in final:
                    final.append(int(alot[var]))
        var+=1
    return final

def final_e(x,y,z):             #restricts equations
    alot=equation_options(equation_options(x,y),z)
    final=[]
    var=0
    while var<len(alot):
        number=eval(alot[var])
        if number==int(number):
            if -10<=number<0 or 0<number<=10:
                final.append(alot[var])
        var+=1
    return final

def bowling(x,y,z):            #combines equations with solutions
    var=0
    solutions=final_s(x,y,z)
    equations=final_e(x,y,z)
    bowl=[]
    while var<len(solutions):
        bowl.append(equations[var]+'='+str(solutions[var]))
        var+=1
    return bowl

game=bowling(die_a,die_b,die_c)                 #formatting outcomes
game.sort(key=lambda x:int(x.rsplit('=',1)[-1]))

print(game)
