
 // 실행 예)
 // 인원 수 입력 : 5
 // 이름 점수 입력(1) : 김진령 90
 // 이름 점수 입력(2) : 장진하 80
 // 이름 점수 입력(3) : 이윤서 85
 // 이름 점수 입력(4) : 이찬호 75
 // 이름 점수 입력(5) : 정미화 95
 /*
 ---------------------
 1등 정미화 95
 2등 김진령 90
 3등 이윤서 85
 4등 장진하 80
 5등 이찬호 75
 ---------------------
 계속하려면 아무 키나 누르세요...
 */

import java.util.Scanner;

class Study017 
{
	public static void main(String[] args) 
	{
		int n=0; // n명째 인원수 저장....
		Scanner sc = new Scanner(System.in);
		
		System.out.print("인원 수 입력 : ");
		n = sc.nextInt();

		String[] name = new String[n];
		int[] score = new int[n];

		for (int i=0; i<name.length; i++)
		{
			System.out.printf("이름 점수 입력(%d) : ", (i+1));
			name[i] = sc.next();
			score[i] = sc.nextInt();

		}

		
		// 정렬....!!!
		
		String temp = " ";
			
		// 바깥 포문이 회차! 1회ㅊ ㅏ 2회차
		// 바깥포문은 1, 첫번째부터~!  --> 향상된 버블 풀때!
		
		for (int i=0; i<name.length-1; i++)
		{
			for (int j=i+1; j<name.length; j++)
			{
				if (score[i]<score[j])
				{
					// score 배열
					score[i] = score[j]^score[i];
					score[j] = score[i]^score[j];
					score[i] = score[j]^score[i];

					temp = name[i];  
					name[i] = name[j];
					name[j] = temp;	

				}
			}
		}

	
		// 출력 구문

		System.out.println("----------------------------");

		for (int i=0; i<score.length; i++)
		{
			System.out.printf("%d등 %s %d\n", i+1, name[i], score[i]);
		}

		System.out.println("----------------------------");
	}
}


