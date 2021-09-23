class Study016 
{
// 실행 예)
// Source Data : 10 50 20 30 40
// Sorted Data : 10 20 30 40 50
// 계속하려면 아무 키나 누르세요...

	public static void main(String[] args)
	{

		// Source Data
		int[] a = {10, 50, 20, 30, 40};

		System.out.print("Source Data : ");
		for (int n : a)
			System.out.print(n + " ");
		System.out.println();
		

		// Sorted Data
		boolean flag;
		int temp;
		int pass=0;

		do
		{
			flag = false;
			pass++;
			
			for (int i=0; i<a.length-pass; i++)
			{	
				if (a[i]> a[i+1])  
				{
					temp = a[i]; 
					a[i] = a[i+1];
					a[i+1] = temp;

					flag = true;
					// 자리바꿈이 발생하게 되면 flag는 true로...
				}
			}
		}
		while (flag); // flag가 true일 동안 반복!

		System.out.print("Sorted Data : ");
		for (int n : a)
			System.out.print(n + " ");
		System.out.println();
	}
}


