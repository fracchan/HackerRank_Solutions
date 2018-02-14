import java.util.*;

public class Solution {

    Map<String, Integer> magazineMap;
    Map<String, Integer> noteMap;
    
    
    private static Map<String,Integer> createMap(String line) {
        Map<String, Integer> mLine = new HashMap<String, Integer>();
        for (String s : line.split(" ")) {
            Integer n = mLine.get(s);
            n = (n == null) ? 1 : ++n;
            mLine.put(s, n);
        }
        return mLine;
    }
    
    public Solution(String magazine, String note) {
        this.magazineMap = createMap(magazine);
        this.noteMap = createMap(note);
    }
    
    public boolean solve() {
        Iterator it = noteMap.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            // ransom - magazine 
            Integer magazineC = magazineMap.get(pair.getKey());
            Integer ransomC = (Integer) pair.getValue();
            if (magazineC == null || (ransomC - magazineC) > 0)
                return false;
        }
        return true;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int m = scanner.nextInt();
        int n = scanner.nextInt();
        
        // Eat whitespace to beginning of next line
        scanner.nextLine();
        
        Solution s = new Solution(scanner.nextLine(), scanner.nextLine());
        scanner.close();
        
        boolean answer = s.solve();
        if(answer)
            System.out.println("Yes");
        else System.out.println("No");
      
    }
}

