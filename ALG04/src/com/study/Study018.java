/*====================================
  ◆◆◆ PART 4. 정렬 알고리즘 ◆◆◆ 
 =====================================*/
// 6. 두 배열의 원소 교체

// 내가 작성한 코드
// A에서 작은 원소 골라서 B에서 가장 큰 원소와 교환....

package com.study;

import java.util.Scanner;

public class Study018 {
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		// 두 정렬 입력받기
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


// 답안 확인
/*
import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // N과 K를 입력받기
        int n = sc.nextInt();
        int k = sc.nextInt();

        // 배열 A의 모든 원소를 입력받기
        Integer[] a = new Integer[n];
        for (int i = 0; i < n; i++) {
            a[i] = sc.nextInt();
        }
        // 배열 B의 모든 원소를 입력받기
        Integer[] b = new Integer[n];
        for (int i = 0; i < n; i++) {
            b[i] = sc.nextInt();
        }

        // 배열 A는 오름차순 정렬 수행
        Arrays.sort(a);
        // 배열 B는 내림차순 정렬 수행
        Arrays.sort(b, Collections.reverseOrder());

        // 첫 번째 인덱스부터 확인하며, 두 배열의 원소를 최대 K번 비교 
        for (int i = 0; i < k; i++) {
            // A의 원소가 B의 원소보다 작은 경우
            if (a[i] < b[i]) {
                // 두 원소를 교체
                int temp = a[i];
                a[i] = b[i];
                b[i] = temp;
            }
            // A의 원소가 B의 원소보다 크거나 같을 때, 반복문을 탈출
            else break;
        }

        // 배열 A의 모든 원소의 합을 출력
        long result = 0;
        for (int i = 0; i < n; i++) {
            result += a[i];
        }
        System.out.println(result);
    }

}
*/