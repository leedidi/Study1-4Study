/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-6. 시각
// 정수 N이 입력되면 00시 00분 00초부터 N시 59분 59초까지의 모든 시각 중에서 3이 하나라도 포함되는 
//  모든 경우의 수를 구하는 프로그램을 작성함...

// 시간 제한 15분 : 9시 56분까지

// 내가 작성한 코드
import java.util.Scanner;

public class Study006
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();	// 입력받을 정수 N

		// 시 분 초.....
		int h = 0;
		int m = 0;
		int s = 0;
		int count = 0; // 경우의 수를 넣을 count 변수
		
		// 모든 시각 중에서 3이 하나라도 포함된다면...
		// 근데 3이 2개, 3개 .. 5개 등등 겹치는 경우 제외?
		// 배열해서 1시~12시, 1분~60분, 1초~60초 넣어서 찾아봐야하나,,,,???

		for (; ; )
		{
			if () // 3이 포함된다면,,, 근데 제외?
			{
			}
		}

		
}

// 답안 확인

import java.util.*;

public class Study006 {

    // 특정한 시각 안에 '3'이 포함되어 있는지의 여부
    public static boolean check(int h, int m, int s) {
        if (h % 10 == 3 || m / 10 == 3 || m % 10 == 3 || s / 10 == 3 || s % 10 == 3)
            return true;
        return false;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // H를 입력받기 
        int h = sc.nextInt();
        int cnt = 0;

        for (int i = 0; i <= h; i++) {
            for (int j = 0; j < 60; j++) {
                for (int k = 0; k < 60; k++) {
                    // 매 시각 안에 '3'이 포함되어 있다면 카운트 증가
                    if (check(i, j, k)) cnt++;
                }
            }
        }

        System.out.println(cnt);
    }

