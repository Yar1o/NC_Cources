package MyFirstPackage;
public class MySecondClass {
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
