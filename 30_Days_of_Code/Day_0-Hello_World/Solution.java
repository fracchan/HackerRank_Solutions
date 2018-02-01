import java.io.*;
import java.util.*;

public class Solution{
  public static void main(String args[]){
    // Create a Scanner object to read input from stdin.
    Scanner scan = new Scanner(System.in);
    // Read a full line of input from stdin and save it to our variable, inputString.
    String inputString = scan.nextLine();
    // Close the scanner object, because we've finished reading inputs.
    scan.close();

    // Print to stdout.
    System.out.println("Hello, World.");
    System.out.println(inputString);
  }
}
