/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-3. 곱하기 혹은 더하기

// 내가 작성한 코드
/*
public class Study003
{
	public static void main(String[] args) 
	{
		// 각 자리가 숫자로만 이루어진 9자리 문자열 S.. 숫자 사이에 x, +를 넣어 결과적으로 만들어질 수 있는 가장 큰 수 구하기
		// 모든 연산은 왼쪽부터 순서대로 이루어짐

		// 숫자가 0, 1이 아니라면 x를 하는게 큰 수를 구하는 방법...

		String a = "123123123";
		System.out.println(a.substring(1,1));
		int fin;
		
		// str.substring(i,i)
		for (int i=1; i< a.length(); i++)
		{
			
			if ()
			{
			}
			
		}

	}
}
*/

// 함께 작성한 코드
import java.util.*;

public class Study003 {

    public static void main(String[] args) 
		{
        Scanner sc = new Scanner(System.in);
		String str = sc.next();

        // 첫 번째 문자를 숫자로 변경한 값을 대입
		long result = str.charAt(0) - '0';
		//-- 이부분 꽤 자주 나올거같음.. 기억하기!
			// 두 수 중에서 하나라도 '0' 혹은 '1'인 경우, 곱하기보다는 더하기 수행
			for (int i = 1; i < str.length(); i++)
			{
				int num = str.charAt(i) - '0';
				if (num <= 1 || result <= 1) 
				{
					result += num;
				}
				else
				{
					result *= num;
				}
			}
        System.out.println(result);
		}
}