import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;
public class Solution {
    public static int numberNeeded(String first, String second) {
        // A default value of 0 for arrays of integral types is guaranteed by the language spec
        int[] freq = new int[26];
        for (char c : first.toCharArray())
            freq[(int)c-97] += 1;
        for (char c : second.toCharArray())
            freq[(int)c-97] -= 1;
        int sum = 0;
        for (int i : freq)
            sum += Math.abs(i);
        return sum;
    }
  
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String a = in.next();
        String b = in.next();
        System.out.println(numberNeeded(a, b));
    }
}
