text= '234+2'
# разделяем строку
print(text.split("+"))

def add(a, b):
    return a + b
    
def sub(a, b):
    return a-b
 
def mul(a, b):
    return a * b
 
def div(a, b):
    return a / b

def logicalc(self, operation):
    if operation == "C":
        self.formula = ""
    elif operation == "DEL":
        self.formula = self.formula[0:-1]
    elif operation == "X^2":
        self.formula = str((eval(self.formula))**2)
    elif operation == "=":
        self.formula = str(eval(self.formula))
    else:
        if self.formula == "0":
            self.formula = ""
        self.formula += operation
    self.update()