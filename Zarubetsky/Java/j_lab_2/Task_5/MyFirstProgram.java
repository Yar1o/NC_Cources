//--- MyFirstProgram.java ------------------------------------------


import MyFirstPackage.MySecondClass;

class MyFirstClass {

//--- MyFirstClass.main --------------------------------------------

public static void main(String[] s) {


//////////<�������� � ������������� ������� �o� ���� MySecondClass>;

MySecondClass o = new MySecondClass();

int i;
int j;
for (i = 1; i <= 8; i++) {
 for(j = 1; j <= 8; j++) {
  //o.<����� ��������� �������� ������� ��������� ����>(i);
  //o.<����� ��������� �������� ������� ��������� ����>(j);

	o.Set_A(i);
	o.Set_B(j);
  System.out.print(o.Summ());
  System.out.print(" ");}
System.out.println();}




}//Main
}//FirstClass







//------------------------------------------------------------------

//------------------------------------------------------------------