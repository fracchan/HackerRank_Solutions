import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {
    
    public static boolean isBalanced(String expression) {
        Stack<Character> s = new Stack<Character>();
        for (char p : expression.toCharArray()) {
            if      (p == '{')   s.push('}');
            else if (p == '[')   s.push(']');
            else if (p == '(')   s.push(')');
            else if (s.empty() || s.pop() != p)
                return false;
        }
        return s.empty();
        
    }
  
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int t = in.nextInt();
        for (int a0 = 0; a0 < t; a0++) {
            String expression = in.next();
            System.out.println( (isBalanced(expression)) ? "YES" : "NO" );
        }
    }
}

