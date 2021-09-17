/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-8. 문자열 재정렬
// 풀이 시간 : 20분

import java.util.Scanner;

class Study008
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		String input = sc.nextLine();
		int suresult;
		
		// 앞에서부터 숫자인지, 문자인지 파악... 알파벳 앞으로 빼서 오름차순 배열, 숫자는 뒤로 빼서 더하기
		for (int i=0; i< input.length(); i++)
		{
			if () // 알파벳이라면 앞으로 빼기... 
			{
			}
			else // 아니라면 숫자 뒤에 더해놓기
			suresult += suresult.charAt(i) - '0';
		}
		// 알파벳 정렬... 

		System.out.println(정렬된 알파벳 + suresult);
	}
}

//답안 확인

import java.util.*;

public class Main {

    public static String str;
    public static ArrayList<Character> result = new ArrayList<Character>();
    public static int value = 0;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        str = sc.next();

        // 문자를 하나씩 확인하며
        for (int i = 0; i < str.length(); i++) {
            // 알파벳인 경우 결과 리스트에 삽입
            if (Character.isLetter(str.charAt(i))) {
                result.add(str.charAt(i));
            }
            // 숫자는 따로 더하기
            else {
                value += str.charAt(i) - '0';
            }
        }

        // 알파벳을 오름차순으로 정렬
        Collections.sort(result);

        // 알파벳을 차례대로 출력
        for (int i = 0; i < result.size(); i++) {
            System.out.print(result.get(i));
        }

        // 숫자가 하나라도 존재하는 경우 가장 뒤에 출력
        if (value != 0) System.out.print(value);
        System.out.println();
    }