#include <stdio.h>
#include <stdlib.h>

int main() {
    float arr[] = { 0.897, 0.656,  0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656 };
    int n = 9;
    float bucket[10][3];
    int i;
    for(i = 0;i<10;i++){
        for(int j = 0;j<3;j++){
            bucket[i][j] = 0;
        }   
    }

    for(i = 0;i<n;i++){
        int bucket_index = 10*arr[i];
        int j=0;
        while(bucket[bucket_index][j]!=0){
            j++;
        }
        bucket[bucket_index][j] = arr[i];
    }
    
    for(int k=0;k<10;k++){
        int i, j;
        float key;
        for (i = 1; i < 3; i++) 
        {
            key = bucket[k][i];
            j = i - 1;
            while (j >= 0 && bucket[k][j] > key) 
            {
                bucket[k][j + 1] = bucket[k][j];
                j = j - 1;
            }
            bucket[k][j + 1] = key;
        }
    }

    int count = n-1;
    for(i = 9;i>=0;i--){
        for(int j = 2;j>=0;j--){
            if(bucket[i][j] != 0){
                arr[count] = bucket[i][j];
                count--;
            }
        }   
    }
    
    printf("Sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("%f ", arr[i]);
    }
    
    return 0;
}