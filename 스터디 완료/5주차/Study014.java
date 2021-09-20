
// 실행 예)
// Source Data : 52 42 12 62 60
// Sorted Data : 12 42 52 60 62
// 계속하려면 아무 키나 누르세요...

class Study014  
{
	public static void main(String[] args) 
	{
		// Source Data
		int[] a = {52, 42, 12, 62, 60};

		int i, j;

		System.out.print("Souce Data : ");

		for (int n : a)
			System.out.print(n+ " ");
		System.out.println();

		// Sorted Data
		for (i=0; i<a.length-1; i++)
		{
			for (j=i+1; j<a.length; j++)
			{
				if (a[i]>a[j])
				{
					a[i] = a[i]^a[j];
					a[j] = a[j]^a[i];
					a[i] = a[i]^a[j];
				}
			}
		}
	
		System.out.print("Sorted Data : ");
		
		for (int n : a)
			System.out.print(n + " ");
		System.out.println();
		

	}
}
