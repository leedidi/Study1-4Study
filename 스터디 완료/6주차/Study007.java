/*====================================
  �ߡߡ� PART 2. �׸��� & ���� �ߡߡ� 
 =====================================*/
// 2-7. �ս��� ����Ʈ
// ����Ʈ ��ġ ǥ�� ���α׷� (2���� ���� �̵�...)

// 8 X 8 ��ǥ ���󿡼� ���� ����Ʈ�� ��ġ�� ���� ��ǥ�� ��Ÿ���� �� ���ڷ� ������ ���ڿ��� �Էµȴ�. (ex : a1)
// ù° �ٿ� ����Ʈ�� �̵��� �� �ִ� ����� ���� ����Ͻÿ� ...

// �ð� ���� 20�� : 10�� 33�б���

// ���� �ۼ��� �ڵ�
import java.util.Scanner;

class Study007 
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		// ���� �̵� �����......
		// ���� ��ġ..... ���� ����.......

		String nowPlace = sc.nextLine();	// ���� ����Ʈ�� ��ġ �Է¹ޱ�
		int row = nowPlace.charAt(1) - '0';
        int column = nowPlace.charAt(0) - 'a' + 1;
	}
}

// ��� Ȯ��
import java.util.*;

public class Study007 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // ���� ����Ʈ�� ��ġ �Է¹ޱ�
        String inputData = sc.nextLine();
        int row = inputData.charAt(1) - '0';
        int column = inputData.charAt(0) - 'a' + 1;

        // ����Ʈ�� �̵��� �� �ִ� 8���� ���� ����
        int[] dx = {-2, -1, 1, 2, 2, 1, -1, -2};
        int[] dy = {-1, -2, -2, -1, 1, 2, 2, 1};

        // 8���� ���⿡ ���Ͽ� �� ��ġ�� �̵��� �������� Ȯ��
        int result = 0;
        for (int i = 0; i < 8; i++) {
            // �̵��ϰ��� �ϴ� ��ġ Ȯ��
            int nextRow = row + dx[i];
            int nextColumn = column + dy[i];
            // �ش� ��ġ�� �̵��� �����ϴٸ� ī��Ʈ ����
            if (nextRow >= 1 && nextRow <= 8 && nextColumn >= 1 && nextColumn <= 8) {
                result += 1;
            }
        }

        System.out.println(result);
    }

}