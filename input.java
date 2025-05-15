blueprint MyClass {
    open static nothing main (number[] args) {
        number a;
        number b;
        a = 5;
        b = 3;
        
        a = a + b;
        show a;

        when (a > b) {
            show b;
        }
        otherwise {
            show a;
        }

        during (a < 20) {
            a = a + 1;
        }

        giveback a;
    }
}
