/*====================================
  �ߡߡ� PART 4. ���� �˰��� �ߡߡ� 
 =====================================*/
// 6. �� �迭�� ���� ��ü

// ���� �ۼ��� �ڵ�
// A���� ���� ���� ��� B���� ���� ū ���ҿ� ��ȯ....

package com.study;

import java.util.Scanner;

public class Study018 {
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		// �� ���� �Է¹ޱ�
		int a = sc.nextInt();
		int b = sc.nextInt();
		
		Integer[] ar = new Integer[a];
		for (int i = 0; i < a; i++) {
			ar[i] = sc.nextInt();
		}
		
		Integer[] br = new Integer[b];
		for (int i = 0; i < b; i++) {
			br[i] = sc.nextInt();
		}
		
	}
}


// ��� Ȯ��
/*
import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // N�� K�� �Է¹ޱ�
        int n = sc.nextInt();
        int k = sc.nextInt();

        // �迭 A�� ��� ���Ҹ� �Է¹ޱ�
        Integer[] a = new Integer[n];
        for (int i = 0; i < n; i++) {
            a[i] = sc.nextInt();
        }
        // �迭 B�� ��� ���Ҹ� �Է¹ޱ�
        Integer[] b = new Integer[n];
        for (int i = 0; i < n; i++) {
            b[i] = sc.nextInt();
        }

        // �迭 A�� �������� ���� ����
        Arrays.sort(a);
        // �迭 B�� �������� ���� ����
        Arrays.sort(b, Collections.reverseOrder());

        // ù ��° �ε������� Ȯ���ϸ�, �� �迭�� ���Ҹ� �ִ� K�� �� 
        for (int i = 0; i < k; i++) {
            // A�� ���Ұ� B�� ���Һ��� ���� ���
            if (a[i] < b[i]) {
                // �� ���Ҹ� ��ü
                int temp = a[i];
                a[i] = b[i];
                b[i] = temp;
            }
            // A�� ���Ұ� B�� ���Һ��� ũ�ų� ���� ��, �ݺ����� Ż��
            else break;
        }

        // �迭 A�� ��� ������ ���� ���
        long result = 0;
        for (int i = 0; i < n; i++) {
            result += a[i];
        }
        System.out.println(result);
    }

}
*/