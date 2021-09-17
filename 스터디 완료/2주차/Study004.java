/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-4. 모험가 길드
// 한 마을에 있는 모험가는 N명
// 공포도가 X인 모험가는 반드시 X명 이상으로 구성한 모험가 그룹에 참여해야 모험을 떠날 수 있음...
// N명의 모험가에 대한 정보가 주어졌을 때, 여행을 떠날 수 있는 그룹 수의 최대값은?

// 11시 25분 - 11시 35분까지 풀어보기
//- 25분 21초

// 내가 작성한 코드
/*
public class Study004
{
	public static void main(String[] args)
	{
		int n; // 모험가의 수
		int x; // 공포도 

		// 공포도가 x인 모험가들은 딱 x명으로 묶어줘야 여행을 떠날 수 있는 그룹 수의 최대값이 됨...
		// 묶어짐이 성공한 모험가들의 그룹 수 = 여행을 떠날 수 있는 그룹 수

		if (공포도가 같다면....)
		{
		}
	}
}
*/

// 답안 확인
// -- 먼저 오름차순 정렬, 이후 현재 확인하는 공포도보다 크거나 같다면, 그룹 생성..! 

import java.util.Scanner;

public class Study004
{
	public static int n;
	public static ArrayList<Integer> arrayList = new ArrayList<>(); //@ 왜 오류나는지...몰겠땅.....

	public static void main(String[] args)
	{
		
		// 공포도가 x인 모험가들은 딱 x명으로 묶어줘야 여행을 떠날 수 있는 그룹 수의 최대값이 됨...
		// 묶어짐이 성공한 모험가들의 그룹 수 = 여행을 떠날 수 있는 그룹 수
		Scanner sc = new Scanner(System.in);
		n = sc.nextInt();

		for (int i=0; i<n; i++)
		{
			arrayList.add(sc.nextInt());
		}
		Collections.sort(arrayList); //ArrayList에 담긴 유형들 간단히 정렬 가능
		
		int result = 0; // 총 그룹의 수
		int count = 0; // 현재 그룹에 포함된 모험가의 수
		for (int i=0; i<n; i++) // 공포도를 낮은 것부터 하나씩 확인하며
		{
			count += 1;	// 현재 그룹에 해당 모험가를 포함시키기
			if (count >= arrayList.get(i)) // 현재 그룹에 포함된 모험가의 수가 현재의 공포도 이상이라면, 그룹 결성
			{
				result += 1;	// 총 그룹의 수 증가시키기
				count = 0;		// 현재 그룹에 포함된 모험가의 수 초기화
			}
		}
		System.out.println(result);
	}
}