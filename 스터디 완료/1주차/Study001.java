/*====================================
  ◆◆◆ PART 2. 그리디 & 구현 ◆◆◆ 
 =====================================*/
// 2-1. 거스름돈 문제 

public class Study001
{
	public static void main(String[] args)
	{	
		
        int n = 1260;
        int cnt = 0;
        int[] coinTypes = {500, 100, 50, 10};
		
        for (int i = 0; i < 4; i++) {
            int coin = coinTypes[i];
            cnt += n / coin;
            n %= coin;
        }
        System.out.println(cnt);	
	}
}
