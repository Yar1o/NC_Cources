//--- MyFirstProgram.java ------------------------------------------
class MyFirstClass {

//--- MyFirstClass.main --------------------------------------------

public static void main(String[] s) {


//////////<Создание и инициализация объекта “o” типа MySecondClass>;

MySecondClass o = new MySecondClass();

int i;
int j;
for (i = 1; i <= 8; i++) {
 for(j = 1; j <= 8; j++) {
  //o.<Метод установки значения первого числового поля>(i);
  //o.<Метод установки значения второго числового поля>(j);

	o.Set_A(i);
	o.Set_B(j);
  System.out.print(o.Summ());
  System.out.print(" ");}
System.out.println();}




}//Main
}//FirstClass


class MySecondClass {
	private int a;
	private int b;

  // конструктор
	public MySecondClass ()
	{
	 this.a=0;
	 this.b=0;
	}

  // методы
	public void Get_A(int a)
	{
	 a=this.a;
	}
	public void Get_B(int b)
	{
	 b=this.b;
	}

	public void Set_A(int a)
	{
	 this.a=a;
	}
	public void Set_B(int b)
	{
	 this.b=b;
	}

  // метод суммирования

	public int Summ()
	{
	 return (this.a + this.b);
	}
}





//------------------------------------------------------------------

//------------------------------------------------------------------