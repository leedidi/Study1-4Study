/*====================================
  ◆◆◆ PART 4. 정렬 알고리즘 ◆◆◆ 
 =====================================*/
// 5. 정렬 라이브러리 기본 예제

package com.study;
import java.util.*;

public class Study017 {

    public static void main(String[] args) {
    	
        int n = 10;
        int[] arr = {7, 5, 9, 0, 3, 1, 6, 2, 4, 8};

        Arrays.sort(arr);

        for(int i = 0; i < n; i++) {
            System.out.print(arr[i] + " ");
        }
    }

}