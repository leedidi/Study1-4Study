/*====================================
  ◆◆◆ PART 3. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-7. 왕실의 나이트
// 나이트 위치 표시 프로그램 (2차원 구현 이동...)

// 8 X 8 좌표 평면상에서 현재 나이트가 위치한 곳의 좌표를 나타내는 두 문자로 구성된 문자열이 입력된다. (ex : a1)
// 첫째 줄에 나이트가 이동할 수 있는 경우의 수를 출력하시오 ...

// 시간 제한 20분 : 10시 33분까지

// 내가 작성한 코드
import java.util.Scanner;

class Study007 
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		// 공간 이동 어려웡......
		// 현재 위치..... 나중 방향.......

		String nowPlace = sc.nextLine();	// 지금 나이트의 위치 입력받기
		
	}
}

// 답안 확인
import java.util.*;

public class Study007 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // 현재 나이트의 위치 입력받기
        String inputData = sc.nextLine();
        int row = inputData.charAt(1) - '0';
        int column = inputData.charAt(0) - 'a' + 1;

        // 나이트가 이동할 수 있는 8가지 방향 정의
        int[] dx = {-2, -1, 1, 2, 2, 1, -1, -2};
        int[] dy = {-1, -2, -2, -1, 1, 2, 2, 1};

        // 8가지 방향에 대하여 각 위치로 이동이 가능한지 확인
        int result = 0;
        for (int i = 0; i < 8; i++) {
            // 이동하고자 하는 위치 확인
            int nextRow = row + dx[i];
            int nextColumn = column + dy[i];
            // 해당 위치로 이동이 가능하다면 카운트 증가
            if (nextRow >= 1 && nextRow <= 8 && nextColumn >= 1 && nextColumn <= 8) {
                result += 1;
            }
        }

        System.out.println(result);
    }

}