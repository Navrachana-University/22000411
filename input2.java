blueprint Operations {
    open static nothing main(number[] args) {
      number a = 8;
      number b = 12;
      number c = 4;
      number result;
  
      result = a + b;
      show result;
  
      result = b - a;
      show result;
  
      result = a * c;
      show result;
  
      result = b / c;
      show result;
  
      when (a < b) {
        show a;
      } otherwise {
        show b;
      }
  
      when (a != c) {
        show a;
        show c;
      } otherwise {
        show result;
      }
  
      during ((a + c) <= b) {
        a = a + 1;
        show a;
      }
  
      giveback result;
    }
  }
  