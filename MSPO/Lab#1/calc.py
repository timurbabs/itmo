from typing import Tuple


def add(x: float, y: float) -> float:
        """This is a function to sum numbers

        Args:
            x (float): number
            y (float): number

        Returns:
            float: x + y
        """
        return x + y

def sub(x: float, y: float) -> float:
        """This is a function to subtraction numbers

        Args:
            x (float): number
            y (float): number

        Returns:
            float: x - y
        """
        return x - y

def mul(x: float, y: float) -> float:
        """This is a function to multiply numbers

        Args:
            x (float): number
            y (float): number

        Returns:
            float: x * y
        """
        return x * y

def div(x: float, y: float) -> float:
        """This is a function to division numbers

        Args:
            x (float): number
            y (float): number

        Raises:
            ZeroDivisionError: division by zero

        Returns:
            [float]: x / y
        """
        if y == 0:
            raise ZeroDivisionError("Division by zero!")
        return x / y

def get_operation() -> str:
        """Get operation from console   

        Raises:
            RuntimeError: do not support this operation 

        Returns:
            str: string where operation contains
        """
        operation = input("0,+,-,*,/\n")
        if operation in ('0','+', '-', '*', '/'):
                return operation
        else:
                raise RuntimeError("Wrong operation!")

def get_variables() -> Tuple[float, float]:
        """Get two variables from console

        Raises:
            ValueError: need to be a number

        Returns:
            tuple: 
        """
        try:
                x = float(input("x = "))
                y = float(input("y = "))
        except ValueError:
                raise ValueError("Wrong format!")
        return (x, y)

def main():
        try:      
                operation = get_operation()
                if operation  == '0':
                        exit(0)
                (x, y) = get_variables()
                if operation == '+':
                        print(add(x, y))
                elif operation == '-':
                        print(sub(x, y))
                elif operation == '*':
                        print(mul(x, y))
                elif operation == '/':
                        print(div(x, y))
        except (RuntimeError, ZeroDivisionError, ValueError) as e:
                print(f"Error occured: {str(e)}")


if __name__ == "__main__":
        main()