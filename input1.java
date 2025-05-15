blueprint Demo {
  open static nothing main(number[] args) {
    number x = 10;
    number y = 20;
    number z;

    z = x * y;
    show z;

    when (z == 200) {
      show x;
      show y;
    } otherwise {
      show z;
    }

    during (x < y) {
      x = x + 2;
      show x;
    }

    giveback z;
  }
}
