
import java.util.Scanner;
import java.io.IOException;

class ReSungjuk
{
	Scanner sc = new Scanner(System.in);
	ReRecord[] rrc;

	public void input() throws IOException
	{

		int inputsu;

		// 인원 수 입력받음
		do
		{
			System.out.print("인원 수 입력(1~100) : ");
			inputsu = sc.nextInt();
		}
		while (inputsu<1 || inputsu>100);
		
		rrc = new ReRecord[inputsu];

		 // 1번째 학생 ~ N번째 학생까지 이름, 국어, 영어, 수학 점수 입력 받음
		 //ReRecord[] rrc = new ReRecord[inputsu];
	
		 for (int i=0; i<inputsu-1; i++)
		 {
			rrc[i]= new ReRecord();
			System.out.printf("%d번째 학생의 이름 입력: ", (i+1));
			rrc[i].name = sc.next();

			String[] title = {"국어 점수 : ", "영어 점수 : ", "수학 점수 : "};

			for (int j=0; j<3; j++)
			{
				System.out.print(title[j]);
				rrc[i].jumsu[j] = sc.nextInt();

				rrc[i].total += rrc[i].jumsu[j];
			}
			rrc[i].avg = rrc[i].total / 3.0;
		 }// end outfor

	}// end input()

	
	public void print()
	{
		for (int i=0; i<rrc.length; i++)
		{
			System.out.print(rrc[i].name);

			for (int j=0; j<3; j++)
			{
				System.out.println();
			}
		}
	}

		// 이름, 국어, 영어, 총점, 등수 출력.....
}
