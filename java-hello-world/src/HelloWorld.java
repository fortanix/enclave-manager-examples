public class HelloWorld {
    public static void main(String[] args)
        throws InterruptedException {
        System.out.println("Hello, World");
        int i = 0;
        while (true) {
            // Pause for 3 seconds
            Thread.sleep(3000);
            System.out.println(++i);
        }
    }
}
