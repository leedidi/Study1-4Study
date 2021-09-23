/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-5. 상하좌우
// A는 N X N 크기의 정사각형 공간 위에 서 있음.가장 왼쪽 위가 (1,1) 가장 오른쪽 아래 좌표가 (N,N)
// 여행가 A는 (1,1)에서 시작해서 상하좌우로 이동 가능... 
// LRUD(왼오위아래) 이동
// N X N 공간을 벗어나는 움직임은 무시된다.
// 시간제한 : 15분 
// - 8시 13분 - 8시 28분
// -유튜브 : 38분 08초

// 내가 작성한 코드
import java.util.Scanner;

public class Study005
{
	public static void main(String[] args) 
	{
		int n;			// 공간의 크기를 나타내는 n
		String[] plan;  // 여행가 A가 이동할 계획서 내용
		
		Scanner sc = new Scanner(System.in);

		// 첫 줄에 N X N 의 N 크기, 둘째 줄에 상하좌우 크기 입력 받기
		n = sc.nextInt();
		System.out.println();
		plan = sc.nextLine().split(" ");

		// 상하좌우 이동시 가져올 배열
		int idong[] = {-1, 0, 1};

	}
}

// 답안
import java.util.*;

public class  {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // N을 입력받기
        int n = sc.nextInt();
        sc.nextLine(); // 버퍼 비우기
        String[] plans = sc.nextLine().split(" ");
        int x = 1, y = 1;

        // L, R, U, D에 따른 이동 방향 
        int[] dx = {0, 0, -1, 1};
        int[] dy = {-1, 1, 0, 0};
        char[] moveTypes = {'L', 'R', 'U', 'D'};

        // 이동 계획을 하나씩 확인
        for (int i = 0; i < plans.length; i++) {
            char plan = plans[i].charAt(0);
            // 이동 후 좌표 구하기 
            int nx = -1, ny = -1;
            for (int j = 0; j < 4; j++) {
                if (plan == moveTypes[j]) {
                    nx = x + dx[j];
                    ny = y + dy[j];
                }
            }
            // 공간을 벗어나는 경우 무시 
            if (nx < 1 || ny < 1 || nx > n || ny > n) continue;
            // 이동 수행 
            x = nx;
            y = ny;
        }

        System.out.println(x + " " + y);
    }

}