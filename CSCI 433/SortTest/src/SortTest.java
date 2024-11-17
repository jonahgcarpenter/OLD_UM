import java.util.Arrays;
import java.util.Random;

public class SortTest {

    // Insertion Sort
    public static void insertionSort(double[] array) {
        for (int i = 1; i < array.length; i++) {
            double key = array[i];
            int j = i - 1;
            while (j >= 0 && array[j] > key) {
                array[j + 1] = array[j];
                j--;
            }
            array[j + 1] = key;
        }
    }

    // Selection Sort
    public static void selectionSort(double[] array) {
        for (int i = 0; i < array.length - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < array.length; j++) {
                if (array[j] < array[minIndex]) {
                    minIndex = j;
                }
            }
            double temp = array[minIndex];
            array[minIndex] = array[i];
            array[i] = temp;
        }
    }

    // Bubble Sort
    public static void bubbleSort(double[] array) {
        int n = array.length;
        boolean swapped;
        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    double temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                    swapped = true;
                }
            }
            if (!swapped) break;
        }
    }

    // Merge Sort
    public static void mergeSort(double[] array) {
        if (array.length > 1) {
            int mid = array.length / 2;
            double[] left = Arrays.copyOfRange(array, 0, mid);
            double[] right = Arrays.copyOfRange(array, mid, array.length);

            mergeSort(left);
            mergeSort(right);

            merge(array, left, right);
        }
    }

    private static void merge(double[] array, double[] left, double[] right) {
        int i = 0, j = 0, k = 0;
        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                array[k++] = left[i++];
            } else {
                array[k++] = right[j++];
            }
        }
        while (i < left.length) {
            array[k++] = left[i++];
        }
        while (j < right.length) {
            array[k++] = right[j++];
        }
    }

    // Quick Sort
    public static void quickSort(double[] array, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(array, low, high);
            quickSort(array, low, pivotIndex - 1);
            quickSort(array, pivotIndex + 1, high);
        }
    }

    private static int partition(double[] array, int low, int high) {
        double pivot = array[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (array[j] < pivot) {
                i++;
                double temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
        }
        double temp = array[i + 1];
        array[i + 1] = array[high];
        array[high] = temp;
        return i + 1;
    }

    // Main method
    public static void main(String[] args) {
        if (args.length != 3) {
            System.out.println("Usage: java SortTest <sort_method> <num_arrays> <array_size>");
            return;
        }

        String method = args[0];
        int numArrays = Integer.parseInt(args[1]);
        int arraySize = Integer.parseInt(args[2]);

        Random random = new Random();
        double[][] arrays = new double[numArrays][arraySize];

        // Generate random arrays
        for (int i = 0; i < numArrays; i++) {
            for (int j = 0; j < arraySize; j++) {
                arrays[i][j] = random.nextDouble();
            }
        }

        long startTime = System.nanoTime();

        // Sort each array using the specified method
        for (int i = 0; i < numArrays; i++) {
            double[] arrayCopy = Arrays.copyOf(arrays[i], arraySize); // Copy each array to avoid sorting the same array
            switch (method.toLowerCase()) {
                case "selection":
                    selectionSort(arrayCopy);
                    break;
                case "insertion":
                    insertionSort(arrayCopy);
                    break;
                case "bubble":
                    bubbleSort(arrayCopy);
                    break;
                case "merge":
                    mergeSort(arrayCopy);
                    break;
                case "quick":
                    quickSort(arrayCopy, 0, arraySize - 1);
                    break;
                default:
                    System.out.println("Invalid sorting method. Choose from selection, insertion, bubble, merge, or quick.");
                    return;
            }
        }

        long endTime = System.nanoTime();
        double avgTimeMillis = (endTime - startTime) / 1_000_000.0 / numArrays;
        System.out.printf("Average running time: %.5f ms\n", avgTimeMillis);
    }
}
