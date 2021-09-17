/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-2. 1이 될 때까지 

// 내가 작성한 코드
/*
public class Study002
{
	public static void main(String[] args)
	{	
		// N, K......
		int n = 21;
		int k = 2;
		int count=0; // 연산 횟수...

		// n에서 1을 빼기 / n을 k로 나누기중 택 1... 1,2 과정을 수행해야 하는 최소 횟수를 구하는 프로그램 구하기
		// n에서 1을 빼는 것보다 k로 나누는게 최소 횟수에 가까워짐
		
		// n을 k로 나눌수 있으면 나누고 나눌수 없다면 -1하기...
		while (true)
		{
			if (n%k == 0)
			{
				n/k
			}
		}
	}
}*/

// 함께 작성한 코드
import java.util.*;

public class Study002 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // N, K를 공백을 기준으로 구분하여 입력 받기
        int n = sc.nextInt();
        int k = sc.nextInt();
        int result = 0;

        while (true) {
            // N이 K로 나누어 떨어지는 수가 될 때까지만 1씩 빼기
            int target = (n / k) * k;
            result += (n - target);
            n = target;
            // N이 K보다 작을 때 (더 이상 나눌 수 없을 때) 반복문 탈출
            if (n < k) break;
            // K로 나누기
            result += 1;
            n /= k;
        }

        // 마지막으로 남은 수에 대하여 1씩 빼기
        result += (n - 1);
        System.out.println(result);
    }

}