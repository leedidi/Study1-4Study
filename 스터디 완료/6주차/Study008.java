/*====================================
  �ߡߡ� PART 2. �׸��� & ���� �ߡߡ� 
 =====================================*/
// 2-8. ���ڿ� ������
// Ǯ�� �ð� : 20��

import java.util.Scanner;

class Study008
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		String input = sc.nextLine();
		int suresult;
		
		// �տ������� ��������, �������� �ľ�... ���ĺ� ������ ���� �������� �迭, ���ڴ� �ڷ� ���� ���ϱ�
		for (int i=0; i< input.length(); i++)
		{
			if () // ���ĺ��̶�� ������ ����... 
			{
			}
			else // �ƴ϶�� ���� �ڿ� ���س���
			suresult += suresult.charAt(i) - '0';
		}
		// ���ĺ� ����... 

		System.out.println(���ĵ� ���ĺ� + suresult);
	}
}

//��� Ȯ��

import java.util.*;

public class Main {

    public static String str;
    public static ArrayList<Character> result = new ArrayList<Character>();
    public static int value = 0;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        str = sc.next();

        // ���ڸ� �ϳ��� Ȯ���ϸ�
        for (int i = 0; i < str.length(); i++) {
            // ���ĺ��� ��� ��� ����Ʈ�� ����
            if (Character.isLetter(str.charAt(i))) {
                result.add(str.charAt(i));
            }
            // ���ڴ� ���� ���ϱ�
            else {
                value += str.charAt(i) - '0';
            }
        }

        // ���ĺ��� ������������ ����
        Collections.sort(result);

        // ���ĺ��� ���ʴ�� ���
        for (int i = 0; i < result.size(); i++) {
            System.out.print(result.get(i));
        }

        // ���ڰ� �ϳ��� �����ϴ� ��� ���� �ڿ� ���
        if (value != 0) System.out.print(value);
        System.out.println();
    }